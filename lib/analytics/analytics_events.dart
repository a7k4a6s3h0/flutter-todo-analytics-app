// Centralized analytics event names
// This file contains only constants 

class AnalyticsEvent {

  // App lifecycle events
  static const String appOpened = 'app_opened';
  static const String appBackgrounded = 'app_backgrounded';

  // Session events
  static const String sessionStart = 'session_start';
  static const String sessionEnd = 'session_end';

  // Navigation events
  static const String screenView = 'screen_view';

  // Core business action
  static const String taskAdded = 'task_added';
  static const String taskCompleted = 'task_completed';
  static const String taskDeleted = 'task_deleted';
  static const String taskUpdated = 'task_updated';

  // Generic interaction tracking
  static const String uiInteraction = 'ui_interaction';


}