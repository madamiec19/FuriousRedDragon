// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:furious_red_dragon/core/app_module.dart' as _i9;
import 'package:furious_red_dragon/data/bloc/auth_bloc.dart' as _i8;
import 'package:furious_red_dragon/data/bloc/login/login_bloc.dart' as _i6;
import 'package:furious_red_dragon/data/bloc/register/register_bloc.dart'
    as _i7;
import 'package:furious_red_dragon/data/repositories/authentication/authentication_repository.dart'
    as _i5;
import 'package:furious_red_dragon/domain/repositories/authentication/i_authentication_repository.dart'
    as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:supabase_flutter/supabase_flutter.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i3.GoTrueClient>(() => appModule.supabaseAuth);
    gh.factory<_i4.IAuthenticationRepository>(
        () => _i5.AuthenticationRepository(gh<_i3.GoTrueClient>()));
    gh.factory<_i6.LoginBloc>(
        () => _i6.LoginBloc(gh<_i4.IAuthenticationRepository>()));
    gh.factory<_i7.RegistrationBloc>(
        () => _i7.RegistrationBloc(gh<_i4.IAuthenticationRepository>()));
    gh.factory<_i8.AuthBloc>(
        () => _i8.AuthBloc(gh<_i4.IAuthenticationRepository>()));
    return this;
  }
}

class _$AppModule extends _i9.AppModule {}
