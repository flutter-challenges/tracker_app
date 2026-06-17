import 'package:flutter/material.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/widgets/dashboard/status_card.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/widgets/dashboard/top_player.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnalyticUi extends StatelessWidget {
  const AnalyticUi({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome Back 👋',
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Ready to track your gaming session performance?',
          style: TextStyle(
            fontSize: 14.sp,
            color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
          ),
        ),
        SizedBox(height: 28.h),

        Row(
          children: [
            const Expanded(
              child: StatCard(
                title: 'Total Sessions',
                value: '0',
                icon: Icons.analytics_rounded,
                color: Colors.blue,
              ),
            ),
            SizedBox(width: 12.w),
            const Expanded(
              child: StatCard(
                title: 'Top Score',
                value: '--',
                icon: Icons.emoji_events_rounded,
                color: Colors.amber,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        const WideStatCard(
          title: 'Top Performing Player',
          value: 'No Data Yet',
          icon: Icons.person_rounded,
          color: Colors.purple,
        ),
      ],
    );
  }
}
