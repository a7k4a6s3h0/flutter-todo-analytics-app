import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'app/app_lifecycle.dart';
import 'features/tasks/task_list_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseAnalytics.instance.logEvent(name: 'manual_test_event');
  final lifecycleObserver = AppLifecycleObserver();
  lifecycleObserver.startObserving();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [
        // navigation analytics observer already added earlier
      ],
      home: const TaskListScreen(),
    );
  }
}
