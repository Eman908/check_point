import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    if (kDebugMode) {
      debugPrint('   Initial state: ${bloc.state}');
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (kDebugMode) {
      debugPrint('   From: ${change.currentState}');
      debugPrint('   To:   ${change.nextState}');
    }
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      debugPrint('🎯 onEvent -- ${bloc.runtimeType}, Event: $event');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (kDebugMode) {
      debugPrint('➡️ onTransition -- ${bloc.runtimeType}');
      debugPrint('   Event: ${transition.event}');
      debugPrint('   From: ${transition.currentState}');
      debugPrint('   To: ${transition.nextState}');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    if (kDebugMode) {
      debugPrint('❌ onError -- ${bloc.runtimeType}');
      debugPrint('   Error: $error');
    }
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    if (kDebugMode) {
      debugPrint('🚪 onClose -- ${bloc.runtimeType} (hash: ${bloc.hashCode})');
    }
  }
}
