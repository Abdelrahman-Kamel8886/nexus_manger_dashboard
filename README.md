# nexus_manger_dashboard

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Flavor Configuration

This project supports multiple flavors that can be specified during build or run commands. Each flavor has its own configuration including primary color, app title, API endpoints, and other settings.

### Running the App with Flavors (Web)

To run the app with a specific flavor, use the `--dart-define` flag with the `FLAVOR` parameter:

```bash
flutter run -d chrome --dart-define=FLAVOR=<flavor_name>
```

**Example:**
```bash
flutter run -d chrome --dart-define=FLAVOR=fawry
```

### Building the App with Flavors (Web)

To build the app for web with a specific flavor:

```bash
flutter build web --dart-define=FLAVOR=<flavor_name>
```

**Example:**
```bash
flutter build web --dart-define=FLAVOR=qnb
```

### Default Flavor

If no flavor is specified via `--dart-define`, the app will use the default flavor configured in the code.

### Notes

- The flavor is read from the `FLAVOR` environment variable at compile time
- Only one `main.dart` file is used - flavors are passed through build/run commands
- All flavor configurations are defined in `lib/core/flavor/flavor_config.dart`
- To add new flavors, update the `Flavor` enum and add corresponding factory methods in `FlavorConfig`