import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/core/dependency_injection.dart';
import 'package:furious_red_dragon/data/bloc/add_edit_item/add_edit_item_bloc.dart';
import 'package:furious_red_dragon/data/bloc/add_report/add_report_bloc.dart';
import 'package:furious_red_dragon/data/bloc/add_room/add_room_bloc.dart';
import 'package:furious_red_dragon/data/bloc/auth_bloc.dart';
import 'package:furious_red_dragon/data/bloc/history_database/history_database_bloc.dart';
import 'package:furious_red_dragon/data/bloc/login/login_bloc.dart';
import 'package:furious_red_dragon/data/bloc/register/register_bloc.dart';
import 'package:furious_red_dragon/data/bloc/report/report_bloc.dart';
import 'package:furious_red_dragon/data/bloc/report_overview/report_overview_bloc.dart';
import 'package:furious_red_dragon/data/bloc/scanner/scanner_bloc.dart';
import 'package:furious_red_dragon/presentation/pages/home/account_tab/add_room.dart';
import 'package:furious_red_dragon/presentation/pages/login_page.dart';
import 'package:furious_red_dragon/presentation/pages/welcome_page.dart';
import 'package:furious_red_dragon/presentation/pages/splash_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'presentation/pages/register_page.dart';

import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://ubjqvkvameebwmsjujbd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVianF2a3ZhbWVlYndtc2p1amJkIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTY5OTA2MjA1NSwiZXhwIjoyMDE0NjM4MDU1fQ.YLPceJ2EnaSBlM_FNeDlRJPp-WMzxySnM5uEgFe4jj0',
  );

  configureDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (_) => getIt<AuthBloc>()..add(AuthInitialCheckRequested()),
        ),
        BlocProvider(
          create: (_) => getIt<LoginBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<RegistrationBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<ScannerBloc>(),
        ),
        BlocProvider(
          create: (_) => getIt<HistoryDatabaseBloc>()
            ..add(HistoryDatabaseInitialCheckRequest())
            ..add(HistoryDatabaseHistoryMenuChosen()),
        ),
        BlocProvider(create: (_) => getIt<ReportBloc>()),
        BlocProvider(
          create: (_) => getIt<AddReportBloc>()..add(AddReportInitial()),
        ),
        BlocProvider(
            create: (_) => getIt<AddRoomBloc>()..add(AddRoomInitial())),
        BlocProvider(create: (_) => getIt<ReportOverviewBloc>()),
        BlocProvider(create: (_) => getIt<AddEditItemBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Furious Red Dragon',
      home: BlocConsumer<AuthBloc, AuthStatus>(
        listener: (context, state) {
          if (state is AuthUserUnauthenticated) {
            Navigator.pushReplacementNamed(context, WelcomePage.routeName);
          }
          if (state is AuthUserAuthenticated) {
            Navigator.pushReplacementNamed(context, HomePage.routeName);
            context
                .read<HistoryDatabaseBloc>()
                .add(HistoryDatabaseInitialCheckRequest());
          }
        },
        builder: (context, state) => const SplashPage(),
      ),
      routes: {
        WelcomePage.routeName: (context) => const WelcomePage(),
        RegisterPage.routeName: (context) => const RegisterPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
        AddRoomPage.routeName: (context) => const AddRoomPage(),
      },
      navigatorKey: MyApp.navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
            backgroundColor: kPageBackgroundColor,
            accentColor: kFuriousRedColor),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: kFuriousRedColor,
          iconTheme: IconThemeData(color: Colors.white),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }
}
