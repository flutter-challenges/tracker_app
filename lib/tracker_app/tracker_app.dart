import 'package:flutter/material.dart';
import 'package:flutter_pro/tracker_app/widgets/tracker_app_body.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackerApp extends StatelessWidget {
  const TrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(home: Scaffold(body: const TrackerAppBody()));
      },
    );
  }
}
