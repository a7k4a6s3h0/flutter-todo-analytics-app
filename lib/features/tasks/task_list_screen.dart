import 'package:flutter/material.dart';

import '../../analytics/analytics_service.dart';
import 'task_model.dart';
import 'add_task_screen.dart';
import '../metrics/metrics_screen.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen({super.key});

  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final AnalyticsService _analyticsService = AnalyticsService();
  final List<TaskModel> _tasks = [];

  void toggleTaskCompletion(TaskModel task) {
    _analyticsService.logUiInteraction('toggle_task_completion');

    setState(() {
      task.isCompleted ? task.markAsIncomplete() : task.markAsCompleted();
    });

    if (task.isCompleted) {
      _analyticsService.logTaskCompleted(task.id);
    }
  }

  void deleteTask(TaskModel task) {
    _analyticsService.logUiInteraction('delete_task');

    _analyticsService.logTaskDeleted(task.id);

    setState(() {
      _tasks.remove(task);
    });
  }

  void updateTask(TaskModel task, String newTitle) {
    _analyticsService.logUiInteraction('update_task');

    setState(() {
      task.updateTitle(newTitle);
    });

    _analyticsService.logTaskUpdated(task.id);
  }


  void _showEditTaskDialog(TaskModel task) {
      final TextEditingController controller =
          TextEditingController(text: task.title);

      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: const Text('Edit Task'),
            content: TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Update task title',
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final newTitle = controller.text.trim();
                  if (newTitle.isNotEmpty && newTitle != task.title) {
                    updateTask(task, newTitle);
                  }
                  Navigator.pop(context);
                },
                child: const Text('Update'),
              ),
            ],
          );
        },
      );
    }


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
              Navigator.push(
                context,
                MaterialPageRoute(
                  settings: const RouteSettings(name: 'Metrics'),
                  builder: (_) => MetricsScreen(),
                ),
              );
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
          // final visibleTasks = _tasks.where((task) => !task.isCompleted);
        },
        child: const Icon(Icons.add),
      ),
      body: _tasks.isEmpty
          ? const Center(child: Text('No tasks yet'))
          : ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (_, index) {
                // return ListTile(
                //   title: Text(_tasks[index].title),
                // );
                return ListTile(
                  leading: Checkbox(
                    value: _tasks[index].isCompleted,
                    onChanged: (_) {
                      toggleTaskCompletion(_tasks[index]);
                    },
                  ),
                  title: Text(
                    _tasks[index].title,
                    style: TextStyle(
                      decoration: _tasks[index].isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!_tasks[index].isCompleted)
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            _showEditTaskDialog(_tasks[index]);
                          },
                        ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteTask(_tasks[index]);
                        },
                      ),
                    ],
                  ),
                );

              },
            ),
    );
  }
}
