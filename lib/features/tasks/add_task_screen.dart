import 'package:flutter/material.dart';

import '../../analytics/analytics_service.dart';
import 'task_model.dart';


class AddTaskScreen  extends StatefulWidget {
  const AddTaskScreen({super.key});

  static const String routeName = '/add_task';

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final TextEditingController _titleController = TextEditingController();
  final AnalyticsService _analyticsService = AnalyticsService();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  void _saveTask() {
    if (_titleController.text.isNotEmpty) {
      final newTask = TaskModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
      );
      Navigator.of(context).pop(newTask);
      _analyticsService.logUiInteraction('save_task_clicked');
      _analyticsService.logTaskAdded();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Task Title',
                border: OutlineInputBorder(),
              ),
              autofocus: true,
              onSubmitted: (_) => _saveTask(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: const Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
