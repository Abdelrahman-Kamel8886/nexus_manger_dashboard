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
  external,
  production;

  String get displayName {
    switch (this) {
      case BuildFilter.all:
        return 'All Builds';
      case BuildFilter.external:
        return 'External';
      case BuildFilter.production:
        return 'Production';
    }
  }

  /// Check if a repository name matches this build filter
  bool matches(String repositoryName) {
    if (this == BuildFilter.all) return true;
    
    final nameLower = repositoryName.toLowerCase();
    switch (this) {
      case BuildFilter.external:
        return nameLower.contains('external');
      case BuildFilter.production:
        return nameLower.contains('production');
      case BuildFilter.all:
        return true;
    }
  }
}

