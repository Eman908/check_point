// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../../features/admin/presentation/views/tabs/profile_tab/cubit/profile_cubit.dart'
    as _i708;
import '../../features/auth/data/data_source/contract/firebase_auth_data_source.dart'
    as _i947;
import '../../features/auth/data/data_source/impl/firebase_auth_data_source_impl.dart'
    as _i6;
import '../../features/auth/data/repo/auth_repo_impl.dart' as _i984;
import '../../features/auth/domain/repo/auth_repo.dart' as _i170;
import '../../features/auth/presentation/cubit/auth_cubit.dart' as _i117;
import '../firebase/auth_service.dart' as _i35;
import '../firebase/users_service.dart' as _i1038;
import 'modules/shared_preference_module.dart' as _i890;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final sharedPreferenceModule = _$SharedPreferenceModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => sharedPreferenceModule.preferences(),
      preResolve: true,
    );
    gh.factory<_i35.AuthService>(() => _i35.AuthService());
    gh.factory<_i1038.UsersService>(() => _i1038.UsersService());
    gh.factory<_i708.ProfileCubit>(() => _i708.ProfileCubit());
    gh.factory<_i117.AuthCubit>(() => _i117.AuthCubit());
    gh.factory<_i947.FirebaseAuthDataSource>(
      () => _i6.FirebaseAuthDataSourceImpl(),
    );
    gh.factory<_i170.AuthRepo>(() => _i984.AuthRepoImpl());
    return this;
  }
}

class _$SharedPreferenceModule extends _i890.SharedPreferenceModule {}
