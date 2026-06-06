
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pro/tracker_app/managers/cubit/tracker.dart';

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
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, 8), // بيخلي الظل نزل لتحت بشكل ناعم
          ),
        ],
        border: Border.all(color: Colors.blue.withOpacity(0.15), width: 1),
      ),
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            name.toUpperCase(),
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A237E), // كحلي شيك
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Score: ',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: const TextStyle(
                  fontSize: 22,
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.add_rounded, size: 20),
            onPressed: () {
              context.read<TrackerCubit>().incrementScore(name);
            },
            label: const Text(
              'Increment',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
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