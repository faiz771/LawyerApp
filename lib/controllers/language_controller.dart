import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class LanguageController extends GetxController {
  RxString _currentLanguage = 'en'.obs; // Default language is English
  final storage = FlutterSecureStorage();

  String get currentLanguage => _currentLanguage.value;

  @override
  void onInit() {
    // Load saved language on app start
    _loadSavedLanguage();
    super.onInit();
    print("yeh hai current language $currentLanguage");
  }

  Future<void> _loadSavedLanguage() async {
    String? savedLanguage = await storage.read(key: 'language');
    if (savedLanguage != null) {
      _currentLanguage.value = savedLanguage;
    }
  }

  Future<void> changeLanguage(String newLanguage) async {
    _currentLanguage.value = newLanguage;
    // Save selected language to storage
    try {
      await storage.write(key: 'language', value: newLanguage);
      print('Language Changed');
      print("yeh hai current language $currentLanguage");
      update();
    } catch (e) {
      print('Failed to change the language');
    }
    update(); // Notify listeners of language change
  }
}
