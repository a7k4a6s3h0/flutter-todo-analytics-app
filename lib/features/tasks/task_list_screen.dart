import 'package:flutter/material.dart';

import '../../analytics/analytics_service.dart';
import 'task_model.dart';
import 'add_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final AnalyticsService _analyticsService = AnalyticsService();
  final List<TaskModel> _tasks = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () {
              _analyticsService.logUiInteraction('open_metrics');
              // Metrics screen will be added later
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _analyticsService.logUiInteraction('open_add_task');

          final TaskModel? newTask = await Navigator.push(
            context,
            MaterialPageRoute(
              settings: const RouteSettings(name: 'AddTask'),
              builder: (_) => const AddTaskScreen(),
            ),
          );

          if (newTask != null) {
            setState(() {
              _tasks.add(newTask);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
      body: _tasks.isEmpty
          ? const Center(child: Text('No tasks yet'))
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(_tasks[index].title),
                );
              },
            ),
    );
  }
}
