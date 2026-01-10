import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app/app_lifecycle.dart';
import 'analytics/analytics_navigation_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  final lifecycleObserver = AppLifecycleObserver();
  lifecycleObserver.startObserving();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [AnalyticsNavigationObserver(),],
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
      },
      home: Scaffold(
        body: Center(
          child: Text('Todo Analytics App'),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context)
  
}