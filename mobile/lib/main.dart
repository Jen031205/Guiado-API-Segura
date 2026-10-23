import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/tasks/presentation/task_page.dart';

void main() {
  runApp(const ProviderScope(child: SecureTaskManagerApp()));
}

/// Root widget for the Secure Task Manager application.
class SecureTaskManagerApp extends StatelessWidget {
  /// Creates the root application widget.
  const SecureTaskManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Task Manager',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const TaskPage(),
    );
  }
}
