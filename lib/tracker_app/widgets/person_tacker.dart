
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pro/tracker_app/managers/cubit/tracker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PersonTracker extends StatelessWidget {
  const PersonTracker({super.key, required this.name, required this.score});
  final String name;
  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8), // بيخلي الظل نزل لتحت بشكل ناعم
          ),
        ],
        border: Border.all(color: Colors.blue.withOpacity(0.15), width: 1.w),
      ),
      padding:  EdgeInsets.all(20.0.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            name.toUpperCase(),
            style:  TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A237E), // كحلي شيك
              letterSpacing: 1.2,
            ),
          ),
           SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Text(
                'Score: ',
                style: TextStyle(fontSize: 14.sp, color: Colors.grey),
              ),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style:  TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                child: Text('$score'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // زرار مودرن ومبهج للـ Increment
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              elevation: 0,
              padding:  EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            icon:  Icon(Icons.add_rounded, size: 20.sp),
            onPressed: () {
              context.read<TrackerCubit>().incrementScore(name);
            },
            label:  Text(
              'Increment',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_pro/indexed_stack/managers/cubit/tracker.dart';

// class PersonTracker extends StatelessWidget {
//   const PersonTracker({super.key, required this.name, required this.score});
//   final String name;
//   final int score;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: <Widget>[
//           Text('Name: $name'),
//           Text('Score: $score'), 
//           TextButton.icon(
//             icon: const Icon(Icons.add),
//             onPressed: () {
//               context.read<TrackerCubit>().incrementScore(name);
//             },
//             label: const Text('Increment'),
//           ),
//         ],
//       ),
//     );
//   }
// }