import 'package:flutter/material.dart';

enum Flavor {
  fawry,
  qnb;

  FlavorConfig get config {
    switch (this) {
      case Flavor.fawry:
        return FlavorConfig.fawry();
      case Flavor.qnb:
        return FlavorConfig.qnb();
    }
  }

  static Flavor? fromString(String? value) {
    if (value == null) return null;
    switch (value.toLowerCase()) {
      case 'fawry':
        return Flavor.fawry;
      case 'qnb':
        return Flavor.qnb;
      default:
        return null;
    }
  }
}

/// Configuration class for app flavors
class FlavorConfig {
  final String name;
  final Color primaryColor;
  final String appTitle;
  final Color? secondaryColor;
  final Color? buttonsColor;
  final Color? footerColor;
  final Color? footerTextColor;
  final String? apiBaseUrl;
  final String? appId;
  final String logoPath;

  const FlavorConfig({
    required this.name,
    required this.primaryColor,
    required this.appTitle,
    required this.logoPath,
    this.secondaryColor,
    this.buttonsColor,
    this.footerColor,
    this.footerTextColor,
    this.apiBaseUrl,
    this.appId,
  });

  /// Fawry flavor configuration
  factory FlavorConfig.fawry() {
    return const FlavorConfig(
      name: 'fawry',
      primaryColor: Color(0xFFFFD400),
      appTitle: 'Nexus Manger Dashboard',
      logoPath: 'assets/fawry_logo.png',
      secondaryColor: Color(0xFF007BFF),
      buttonsColor: Color(0xFF007BFF),
      footerColor: Color(0xFF00699C),
      footerTextColor: Colors.white,
      apiBaseUrl: 'https://api.fawry.com',
      appId: 'com.fawry.dashboard',
    );
  }

  /// QNB flavor configuration
  factory FlavorConfig.qnb() {
    return const FlavorConfig(
      name: 'qnb',
      primaryColor: Color(0xFF870052), // QNB red
      appTitle: 'QNB Wallet Manger Dashboard',
      logoPath: 'assets/qnb_logo.png',
      secondaryColor: Color(0xFFB8142A),
      buttonsColor: Color(0xFF870052),
      footerColor: Color(0xFF870052),
      footerTextColor: Colors.white,
      apiBaseUrl: 'https://api.qnb.com',
      appId: 'com.qnb.dashboard',
    );
  }

  /// Get theme data based on flavor configuration
  ThemeData get themeData {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        secondary: secondaryColor ?? primaryColor,
      ),
      useMaterial3: true,
    );
  }
}
