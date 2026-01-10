import 'package:flutter/widgets.dart';

import '../analytics/analytics_service.dart';

/// Observes app lifecycle changes to track sessions accurately.
class AppLifecycleObserver extends WidgetsBindingObserver {
  final AnalyticsService _analyticsService = AnalyticsService();

  // AppLifecycleObserver(this._analyticsService);
  DateTime? _sessionStartTime;

  /// Start observing lifecycle changes
  void startObserving() {
    WidgetsBinding.instance.addObserver(this);
  }

  /// Stop observing lifecycle changes
  void stopObserving() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _analyticsService.logAppOpened();
        _analyticsService.logSessionStart();
        _sessionStartTime = DateTime.now();
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
        if(_sessionStartTime == null) return;
        final sessionDuration = DateTime.now().difference(_sessionStartTime!);
        _analyticsService.logAppBackgrounded();
        _analyticsService.logSessionEnd();
        _sessionStartTime = null;
        break;
      case AppLifecycleState.detached:
        _analyticsService.logSessionEnd();
        break;
      case AppLifecycleState.hidden:
        // TODO: Handle this case if needed for specific analytics
        break;
    }
  }

}