import '../service_locators/service_locators.dart';

Future<void> initializeApp() async {
  setupLocator();
  await locator.allReady();
}
