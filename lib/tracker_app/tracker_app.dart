import 'package:flutter/material.dart';
import 'package:flutter_pro/tracker_app/widgets/tracker_app_body.dart';

class TrackerApp extends StatelessWidget {
  const TrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: const TrackerAppBody(),
      ),
    );
  }
}
