import 'package:flutter/material.dart';

enum PlatformFilter {
  all,
  android,
  ios;

  String get displayName {
    switch (this) {
      case PlatformFilter.all:
        return 'All Platforms';
      case PlatformFilter.android:
        return 'Android';
      case PlatformFilter.ios:
        return 'iOS';
    }
  }

  IconData get icon {
    switch (this) {
      case PlatformFilter.android:
        return Icons.android;
      case PlatformFilter.ios:
        return Icons.apple;
      case PlatformFilter.all:
        return Icons.devices;
    }
  }

  bool matches(String repositoryName) {
    if (this == PlatformFilter.all) return true;
    
    final nameLower = repositoryName.toLowerCase();
    switch (this) {
      case PlatformFilter.android:
        return nameLower.contains('android');
      case PlatformFilter.ios:
        return nameLower.contains('ios');
      case PlatformFilter.all:
        return true;
    }
  }
}

enum BuildFilter {
  all,
  dev,
  secon,
  partial,
  production;

  String get displayName {
    switch (this) {
      case BuildFilter.all:
        return 'All Builds';
      case BuildFilter.secon:
        return 'SecOn';
      case BuildFilter.production:
        return 'Production';
      case BuildFilter.dev:
        return 'Dev';
      case BuildFilter.partial:
        return 'Partial SecOn';
    }
  }

  IconData get icon {
    switch (this) {
      case BuildFilter.secon:
        return Icons.lock;
      case BuildFilter.production:
        return Icons.public;
      case BuildFilter.all:
        return Icons.all_inclusive;
      case BuildFilter.dev:
        return Icons.handyman;
      case BuildFilter.partial:
        return Icons.lock_open;
    }
  }

  bool matches(String repositoryName) {
    if (this == BuildFilter.all) return true;
    
    final nameLower = repositoryName.toLowerCase();
    switch (this) {
      case BuildFilter.secon:
        return nameLower.contains('secon');
      case BuildFilter.production:
        return nameLower.contains('production');
      case BuildFilter.all:
        return true;
      case BuildFilter.dev:
        return nameLower.contains('dev');
      case BuildFilter.partial:
        return nameLower.contains('partial');
    }
  }
}

