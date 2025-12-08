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
  final String? apiBaseUrl;
  final String? appId;

  const FlavorConfig({
    required this.name,
    required this.primaryColor,
    required this.appTitle,
    this.secondaryColor,
    this.apiBaseUrl,
    this.appId,
  });

  /// Fawry flavor configuration
  factory FlavorConfig.fawry() {
    return const FlavorConfig(
      name: 'fawry',
      primaryColor: Color(0xFF00A859),
      // Fawry green
      appTitle: 'Fawry Dashboard',
      secondaryColor: Color(0xFF006B3C),
      apiBaseUrl: 'https://api.fawry.com',
      appId: 'com.fawry.dashboard',
    );
  }

  /// QNB flavor configuration
  factory FlavorConfig.qnb() {
    return const FlavorConfig(
      name: 'qnb',
      primaryColor: Color(0xFFE31837),
      // QNB red
      appTitle: 'QNB Dashboard',
      secondaryColor: Color(0xFFB8142A),
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
