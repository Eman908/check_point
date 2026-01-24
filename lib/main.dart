import 'package:check_point/core/di/di.dart';
import 'package:check_point/core/utils/bloc_observer.dart';
import 'package:check_point/firebase_options.dart';
import 'package:check_point/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  runApp(const CheckPoint());
}
