import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SessionTimer extends StatelessWidget {
  const SessionTimer({
    super.key,
    required this.timerText,
    required this.currentWinner,
  });

  final String timerText;
  final String currentWinner;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      margin: EdgeInsets.symmetric(horizontal: 24.w),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.08),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text(
                '⏱️ Live Timer',
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),
              Text(
                timerText,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              children: [
                Text(
                  '👑 Current Leader',
                  style: TextStyle(color: Colors.grey, fontSize: 12.sp),
                ),
                Text(
                  textAlign: TextAlign.center,
                  currentWinner,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.amber.shade800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
