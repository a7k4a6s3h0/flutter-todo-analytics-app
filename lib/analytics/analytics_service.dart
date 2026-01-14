import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'analytics_events.dart';
import '../data/local_storage.dart';
    
/// Central service responsible for all analytics tracking.
class AnalyticsService {

  static final AnalyticsService _singleton = AnalyticsService._internal();

  factory AnalyticsService() {
    return _singleton;
  }

  AnalyticsService._internal();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  /// Logs a generic event
  Future<void> logEvent(String eventName,
      {Map<String, Object?>? parameters}) async {
    await _analytics.logEvent(
      name: eventName,
      parameters: parameters,
    );
  }

  // App Opened
  Future<void> logAppOpened() async {
    await logEvent(AnalyticsEvent.appOpened);
  }

  /// App sent to background
  Future<void> logAppBackgrounded() async {
    await logEvent(AnalyticsEvent.appBackgrounded);
  }

  /// Session started
  Future<void> logSessionStart() async {
    await logEvent(AnalyticsEvent.sessionStart);
  }

  /// session ended
  Future<void> logSessionEnd() async {
    await logEvent(AnalyticsEvent.sessionEnd);
  }

  
  // Screen Navigation
  Future<void> logScreenView(String screenName,
      {String? previousScreen}) async {
    await _analytics.logScreenView(
      screenName: screenName,
      screenClass: screenName,
    );
    await logEvent(AnalyticsEvent.screenView,
        parameters: {
          'screen_name': screenName, 
          if (previousScreen != null) 'previous_screen': previousScreen
        });
  }

  /// Core business action
  Future<void> logTaskAdded() async {
    LocalAnalyticsStorage().taskAddedCount++;
    await logEvent(AnalyticsEvent.taskAdded);
  }
  Future<void> logTaskCompleted(String taskId) async {
    await logEvent(AnalyticsEvent.taskCompleted, parameters: {'task_id': taskId});
  }
  Future<void> logTaskDeleted(String taskId) async {
    await logEvent(AnalyticsEvent.taskDeleted, parameters: {'task_id': taskId});
  }
  Future<void> logTaskUpdated(String taskId) async {
    await logEvent(AnalyticsEvent.taskUpdated, parameters: {'task_id': taskId});
  }

  /// Generic interaction counter
  Future<void> logUiInteraction(String interactionType) async {
    LocalAnalyticsStorage().totalInteractions++;
    await logEvent(AnalyticsEvent.uiInteraction,
        parameters: {'interaction_type': interactionType});
  }

}


