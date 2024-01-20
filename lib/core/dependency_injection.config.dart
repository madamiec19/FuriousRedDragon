// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:furious_red_dragon/core/app_module.dart' as _i18;
import 'package:furious_red_dragon/data/bloc/auth_bloc.dart' as _i16;
import 'package:furious_red_dragon/data/bloc/history_database/history_database_bloc.dart'
    as _i17;
import 'package:furious_red_dragon/data/bloc/login/login_bloc.dart' as _i12;
import 'package:furious_red_dragon/data/bloc/register/register_bloc.dart'
    as _i13;
import 'package:furious_red_dragon/data/bloc/report/report_bloc.dart' as _i14;
import 'package:furious_red_dragon/data/bloc/scanner/scanner_bloc.dart' as _i15;
import 'package:furious_red_dragon/data/repositories/authentication/authentication_repository.dart'
    as _i5;
import 'package:furious_red_dragon/data/repositories/items/items_repository.dart'
    as _i7;
import 'package:furious_red_dragon/data/repositories/reports/reports_repository.dart'
    as _i9;
import 'package:furious_red_dragon/data/repositories/rooms/rooms_repository.dart'
    as _i11;
import 'package:furious_red_dragon/domain/repositories/authentication/i_authentication_repository.dart'
    as _i4;
import 'package:furious_red_dragon/domain/repositories/items/i_items_repository.dart'
    as _i6;
import 'package:furious_red_dragon/domain/repositories/reports/i_reports_repository.dart'
    as _i8;
import 'package:furious_red_dragon/domain/repositories/rooms/i_rooms_repository.dart'
    as _i10;
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
    gh.factory<_i3.SupabaseClient>(() => appModule.supabaseDb);
    gh.factory<_i4.IAuthenticationRepository>(
        () => _i5.AuthenticationRepository(
              gh<_i3.GoTrueClient>(),
              gh<_i3.SupabaseClient>(),
            ));
    gh.factory<_i6.IItemsRepository>(
        () => _i7.ItemsRepository(gh<_i3.SupabaseClient>()));
    gh.factory<_i8.IReportsRepository>(
        () => _i9.ReportsRepository(gh<_i3.SupabaseClient>()));
    gh.factory<_i10.IRoomsRepository>(
        () => _i11.RoomRepository(gh<_i3.SupabaseClient>()));
    gh.factory<_i12.LoginBloc>(
        () => _i12.LoginBloc(gh<_i4.IAuthenticationRepository>()));
    gh.factory<_i13.RegistrationBloc>(
        () => _i13.RegistrationBloc(gh<_i4.IAuthenticationRepository>()));
    gh.factory<_i14.ReportBloc>(() => _i14.ReportBloc(
          gh<_i8.IReportsRepository>(),
          gh<_i4.IAuthenticationRepository>(),
        ));
    gh.factory<_i15.ScannerBloc>(
        () => _i15.ScannerBloc(gh<_i6.IItemsRepository>()));
    gh.factory<_i16.AuthBloc>(
        () => _i16.AuthBloc(gh<_i4.IAuthenticationRepository>()));
    gh.factory<_i17.HistoryDatabaseBloc>(() => _i17.HistoryDatabaseBloc(
          gh<_i6.IItemsRepository>(),
          gh<_i4.IAuthenticationRepository>(),
        ));
    return this;
  }
}

class _$AppModule extends _i18.AppModule {}
