import 'package:flutter/material.dart';

import '../../data/session_repository.dart';

class MetricsScreen extends StatelessWidget {
  MetricsScreen({super.key});

  final MetricsRepository _metrics = MetricsRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Developer Metrics')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Average Session Length: '
              '${_metrics.averageSessionLength.toStringAsFixed(1)} sec',
            ),
            const SizedBox(height: 12), 
            Text(
              'Feature Adoption Rate: '
              '${(_metrics.featureAdoptionRate * 100).toStringAsFixed(1)}%',
            ),
            const SizedBox(height: 12),
            Text(
              'App Opens (Last 24h): '
              '${_metrics.frequencyLastHours(24)}',
            ),
          ],
        ),
      ),
    );
  }
}
