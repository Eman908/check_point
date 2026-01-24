import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class SharedPreferenceModule {
  @preResolve
  Future<SharedPreferences> preferences() async {
    return await SharedPreferences.getInstance();
  }
}
