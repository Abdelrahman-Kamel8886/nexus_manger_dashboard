import 'flavor_config.dart';

Flavor get currentFlavor {
  const flavorString = String.fromEnvironment('FLAVOR', defaultValue: 'fawry');
  final flavor = Flavor.fromString(flavorString);
  
  if (flavor == null) {
    throw Exception(
      'Invalid flavor: $flavorString.',
    );
  }
  
  return flavor;
}
FlavorConfig get flavorConfig => currentFlavor.config;


