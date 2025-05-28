import 'package:get/get.dart';

class SettingsController extends GetxController {
  // User information
  final RxString userName = 'Zacky'.obs;
  
  // Settings toggle values
  final RxBool notificationsEnabled = true.obs;
  final RxBool autoDownloadEnabled = false.obs;
  final RxBool syncEnabled = true.obs;
  
  // Theme options
  final RxString currentTheme = 'Terang'.obs;
  final RxString currentFontSize = 'Normal'.obs;
  final RxString currentLanguage = 'Indonesia'.obs;
  
  @override
  void onInit() {
    super.onInit();
    _loadUserSettings();
  }
  
  // Load user settings on init
  void _loadUserSettings() {
    // In a real app, you would load these from SharedPreferences or other storage
    userName.value = 'Zacky';
    notificationsEnabled.value = true;
    autoDownloadEnabled.value = false;
    syncEnabled.value = true;
    currentTheme.value = 'Terang';
    currentFontSize.value = 'Normal';
    currentLanguage.value = 'Indonesia';
  }
  
  // Toggle functions
  void toggleNotifications() {
    notificationsEnabled.value = !notificationsEnabled.value;
    // In a real app, you would save this setting
  }
  
  void toggleAutoDownload() {
    autoDownloadEnabled.value = !autoDownloadEnabled.value;
    // In a real app, you would save this setting
  }
  
  void toggleSync() {
    syncEnabled.value = !syncEnabled.value;
    // In a real app, you would save this setting
  }
  
  // Theme settings
  void setTheme(String theme) {
    currentTheme.value = theme;
    // In a real app, you would implement theme changing logic
  }
  
  void setFontSize(String size) {
    currentFontSize.value = size;
    // In a real app, you would implement font size changing logic
  }
  
  void setLanguage(String language) {
    currentLanguage.value = language;
    // In a real app, you would implement language changing logic
  }
  
  void logout() {
    // In a real app, you would implement logout logic
    Get.offAllNamed('/login');
  }
}