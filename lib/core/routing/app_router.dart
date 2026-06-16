import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pro/core/routing/app_routes.dart';
import 'package:flutter_pro/tracker_app/session_feature/managers/game_session_cubit/game_session_cubit_cubit.dart';
import 'package:flutter_pro/tracker_app/session_feature/managers/game_session_cubit/game_session_cubit_state.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/views/tracker_active_view.dart';
import 'package:flutter_pro/tracker_app/session_feature/presentation/views/tracker_app_view.dart';

class AppRouter {
  // بنعمل الـ Cubit كـ singleton أو instance ثابت جوه الـ Router للـ Feature دي
  static final GameSessionCubit _gameSessionCubit = GameSessionCubit();

  static Route generateRoute(RouteSettings settings) {
    return switch (settings.name) {
      
      AppRoutes.trackerAppView => MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _gameSessionCubit, // بنستخدم .value عشان نمرر الـ Cubit اللي جاهز فعلاً
            child: const TrackerAppView(),
          ),
        ),

      AppRoutes.trackerActiveView => MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: _gameSessionCubit, // نفس الـ Cubit بنفس الداتا والـ state
            child: TrackerActiveView(
              gameSessionActiveState: settings.arguments as GameSessionActive,
            ),
          ),
        ),

      _ => MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(child: Text('Route not found')),
          ),
        ),
    };
  }
}