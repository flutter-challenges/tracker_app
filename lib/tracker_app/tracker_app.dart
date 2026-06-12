import 'package:flutter/material.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/views/tracker_app_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*
  * This is the root of tracker app.
*/
class TrackerApp extends StatelessWidget {
  const TrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(home: Scaffold(body: const TrackerAppView()));
      },
    );
  }
}
