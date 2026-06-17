import 'package:flutter/material.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/widgets/dashboard/action_section.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/widgets/dashboard/analytic_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackerInitialView extends StatelessWidget {
  const TrackerInitialView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnalyticUi(),
            SizedBox(height: 32.h),
            Text(
              'Actions & History',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 12.h),
            ActionSection(),
          ],
        ),
      ),
    );
  }
}
