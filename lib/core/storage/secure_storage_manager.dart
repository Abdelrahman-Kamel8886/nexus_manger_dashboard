import 'dart:html' as html;
import 'package:encrypt/encrypt.dart';

class SecureStorageManager {
  // Generate a consistent key for web (32 bytes = 256 bits for AES-256)
  // In production, consider using a key derivation function or secure key management
  // Using a fixed 32-byte key encoded in base64
  static final _key = Key.fromBase64('QUJDREVGR0hJSktMTU5PUFFSU1RVVldYWVphYmNkZWY='); // 32 bytes: ABCDEFGHIJKLMNOPQRSTUVWXYZabcdef
  static final _iv = IV.fromLength(16);
  static final _encrypter = Encrypter(AES(_key));

  // Keys
  static const String _usernameKey = 'encrypted_username';
  static const String _fallbackUsernameKey = 'username';

  /// Save username securely (encrypted) using localStorage
  static Future<void> saveUsername(String username) async {
    try {
      final encrypted = _encrypter.encrypt(username, iv: _iv);
      html.window.localStorage[_usernameKey] = encrypted.base64;
    } catch (e) {
      // Fallback to unencrypted storage if encryption fails
      html.window.localStorage[_fallbackUsernameKey] = username;
    }
  }

  /// Get saved username (decrypted) from localStorage
  static Future<String?> getUsername() async {
    try {
      final encryptedValue = html.window.localStorage[_usernameKey];
      
      if (encryptedValue != null && encryptedValue.isNotEmpty) {
        final encrypted = Encrypted.fromBase64(encryptedValue);
        return _encrypter.decrypt(encrypted, iv: _iv);
      }
      
      // Fallback to unencrypted storage
      return html.window.localStorage[_fallbackUsernameKey];
    } catch (e) {
      // If decryption fails, try unencrypted
      return html.window.localStorage[_fallbackUsernameKey];
    }
  }

  /// Clear username (logout) from localStorage
  static Future<void> clearUsername() async {
    html.window.localStorage.remove(_usernameKey);
    html.window.localStorage.remove(_fallbackUsernameKey);
  }

  /// Clear all stored data from localStorage
  static Future<void> clearAll() async {
    html.window.localStorage.clear();
  }
}

