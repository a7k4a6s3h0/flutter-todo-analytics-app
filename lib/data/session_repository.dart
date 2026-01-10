import 'local_storage.dart';

class MetricsRepository {
  final LocalAnalyticsStorage _storage = LocalAnalyticsStorage();

  double get averageSessionLength {
    if (_storage.sessionDurations.isEmpty) return 0;

    final total = _storage.sessionDurations.reduce((a, b) => a + b);
    return total / _storage.sessionDurations.length;
  }

  double get featureAdoptionRate {
    print('Interactions: ${_storage.totalInteractions}');
    print('Tasks added: ${_storage.taskAddedCount}');


    if (_storage.totalInteractions == 0) return 0;

    return _storage.taskAddedCount / _storage.totalInteractions;
  }

  int frequencyLastHours(int hours) {
    final cutoff =
        DateTime.now().subtract(Duration(hours: hours));

    return _storage.appLaunchTimes
        .where((time) => time.isAfter(cutoff))
        .length;
  }
}
