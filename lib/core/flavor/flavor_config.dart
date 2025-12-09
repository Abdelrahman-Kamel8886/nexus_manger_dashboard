import 'package:flutter/material.dart';

enum Flavor {
  fawry,
  qnb,
  we;

  FlavorConfig get config {
    switch (this) {
      case Flavor.fawry:
        return FlavorConfig.fawry();
      case Flavor.qnb:
        return FlavorConfig.qnb();
      case Flavor.we:
        return FlavorConfig.we();
    }
  }

  static Flavor? fromString(String? value) {
    if (value == null) return null;
    switch (value.toLowerCase()) {
      case 'fawry':
        return Flavor.fawry;
      case 'qnb':
        return Flavor.qnb;
      case 'we':
        return Flavor.we;
      default:
        return null;
    }
  }
}

class FlavorConfig {
  final String name;
  final Color primaryColor;
  final String appTitle;
  final Color? secondaryColor;
  final Color? buttonsColor;
  final Color? footerColor;
  final Color? footerTextColor;
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
  });

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
    );
  }

  factory FlavorConfig.qnb() {
    return const FlavorConfig(
      name: 'qnb',
      primaryColor: Color(0xFF870052),
      appTitle: 'QNB Wallet Manger Dashboard',
      logoPath: 'assets/qnb_logo.png',
      secondaryColor: Color(0xFFB8142A),
      buttonsColor: Color(0xFF870052),
      footerColor: Color(0xFF870052),
      footerTextColor: Colors.white,
    );
  }
  factory FlavorConfig.we() {
    return const FlavorConfig(
      name: 'we',
      primaryColor: Color(0xFF5C2D91),
      appTitle: 'WE Wallet Manager Dashboard',
      logoPath: 'assets/we_logo.png',
      secondaryColor: Color(0xFF004499),
      buttonsColor: Color(0xFF5C2D91),
      footerColor: Color(0xFF5C2D91),
      footerTextColor: Colors.white,
    );
  }

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
