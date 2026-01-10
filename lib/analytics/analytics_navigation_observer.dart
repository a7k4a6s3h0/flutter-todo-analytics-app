import 'package:flutter/material.dart';

import 'analytics_service.dart';

/// Observes navigation changes and logs screen views automatically.
class AnalyticsNavigationObserver extends NavigatorObserver {
  final AnalyticsService _analyticsService = AnalyticsService();

  String? _previousScreen;

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _logScreen(route.settings.name);
    super.didPush(route, previousRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    if (previousRoute != null) {
      _logScreen(previousRoute.settings.name);
    }
    super.didPop(route, previousRoute);
  }

  void _logScreen(String? screenName) {
    if (screenName == null) return;

    _analyticsService.logScreenView(
      screenName,
      previousScreen: _previousScreen,
    );

    _previousScreen = screenName;
  }
}
