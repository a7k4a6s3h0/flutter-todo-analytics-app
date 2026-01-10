/// Simple in-memory storage for analytics data.
/// Can be replaced with persistent storage later.
class LocalAnalyticsStorage {
  static final LocalAnalyticsStorage _instance =
      LocalAnalyticsStorage._internal();

  factory LocalAnalyticsStorage() => _instance;

  LocalAnalyticsStorage._internal();

  // Raw data stores
  final List<int> sessionDurations = [];
  int totalInteractions = 0;
  int taskAddedCount = 0;
  final List<DateTime> appLaunchTimes = [];
}
