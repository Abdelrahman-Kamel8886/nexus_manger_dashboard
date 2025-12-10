import 'package:flutter/material.dart';

enum Flavor {
  fawry,
  adcb,
  bm,
  qnb,
  nbe,
  we;

  FlavorConfig get config {
    switch (this) {
      case Flavor.fawry:
        return FlavorConfig.fawry();
      case Flavor.qnb:
        return FlavorConfig.qnb();
      case Flavor.we:
        return FlavorConfig.we();
      case Flavor.nbe:
        return FlavorConfig.nbe();
      case Flavor.adcb:
        return FlavorConfig.adcb();
      case Flavor.bm:
        return FlavorConfig.bm();
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
      case 'nbe':
        return Flavor.nbe;
      case 'adcb':
        return Flavor.adcb;
      case 'bm':
        return Flavor.bm;
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
      appTitle: 'Nexus Manger',
      logoPath: 'assets/fawry.png',
      secondaryColor: Color(0xFF00699C),
      buttonsColor: Color(0xFF007BFF),
      footerColor: Color(0xFF00699C),
      footerTextColor: Colors.white,
    );
  }

  factory FlavorConfig.adcb() {
    return const FlavorConfig(
      name: 'adcb',
      primaryColor: Color(0xFFCC3366),
      appTitle: 'Wa2ty Manger',
      logoPath: 'assets/banks/adcb.png',
      secondaryColor: Color(0xFF333F48),
      buttonsColor: Color(0xFFCC3366),
      footerColor: Color(0xFF333F48),
      footerTextColor: Colors.white,
    );
  }

  factory FlavorConfig.qnb() {
    return const FlavorConfig(
      name: 'qnb',
      primaryColor: Color(0xFF870052),
      appTitle: 'E-Wallet Manger',
      logoPath: 'assets/banks/qnb.png',
      secondaryColor: Color(0xFFB8142A),
      buttonsColor: Color(0xFF870052),
      footerColor: Color(0xFF870052),
      footerTextColor: Colors.white,
    );
  }

  factory FlavorConfig.bm() {
    return const FlavorConfig(
      name: 'bm',
      primaryColor: Color(0xFF871E35),
      appTitle: 'BM Wallet Manger',
      logoPath: 'assets/banks/bm.png',
      secondaryColor: Color(0xFF2E2E2E),
      buttonsColor: Color(0xFF871E35),
      footerColor: Color(0xFF2E2E2E),
      footerTextColor: Colors.white,
    );
  }

  factory FlavorConfig.nbe() {
    return const FlavorConfig(
      name: 'nbe',
      primaryColor: Color(0xFF00643E),
      appTitle: 'PhoneCash Manger',
      logoPath: 'assets/banks/nbe.png',
      secondaryColor: Color(0xFFB8142A),
      buttonsColor: Color(0xFFFFA100),
      footerColor: Color(0xFF00643E),
      footerTextColor: Colors.white,
    );
  }

  factory FlavorConfig.we() {
    return const FlavorConfig(
      name: 'we',
      primaryColor: Color(0xFF5C2D91),
      appTitle: 'WE Pay Manager',
      logoPath: 'assets/banks/we.png',
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
