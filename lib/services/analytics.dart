import 'package:firebase_analytics/firebase_analytics.dart';

class AppAnalytics {
  static final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  static Future<void> setUserId(String userId) async {
    await analytics.setUserId(id: userId);
  }

  static Future<void> setScreenName(String screenName) async {
    await analytics.setCurrentScreen(screenName: screenName);
  }

  static Future<void> logCustomEvent(
      String logName, Map<String, dynamic> map) async {
    await analytics.logEvent(name: logName, parameters: map);
  }
}
