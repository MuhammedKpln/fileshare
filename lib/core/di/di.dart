import 'package:boilerplate/core/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Creating a singleton instance of GetIt.
final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)

/// It configures the GetIt instance.
void configureDependencies() => $initGetIt(getIt);
