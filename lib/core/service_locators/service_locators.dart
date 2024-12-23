import 'package:bloc_testing/core/shared_preferences_storage/storage_service.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/post_repository.dart';

final locator = GetIt.instance;

void setupLocator() async {
  locator.registerSingletonAsync<SharedPreferences>(
    () async => SharedPreferences.getInstance(),
  );

  locator.registerSingletonWithDependencies<SharedPreferencesStorage>(
    () => SharedPreferencesStorage(
      sharedPreferences: locator(),
    ),
    dependsOn: [SharedPreferences],
  );

  locator.registerLazySingleton<PostRepository>(
    () => PostRepository(),
  );
}
