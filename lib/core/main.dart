import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/core/dependency_injection.dart';
import 'package:furious_red_dragon/data/bloc/auth_bloc.dart';
import 'package:furious_red_dragon/data/bloc/login/login_bloc.dart';
import 'package:furious_red_dragon/data/bloc/register/register_bloc.dart';
import 'package:furious_red_dragon/presentation/pages/home/add_room.dart';
import 'package:furious_red_dragon/presentation/pages/home/history_tab/room_details_screen.dart';
import 'package:furious_red_dragon/presentation/pages/login_page.dart';
import 'package:furious_red_dragon/presentation/pages/welcome_page.dart';
import 'package:furious_red_dragon/presentation/pages/splash_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../presentation/pages/register_page.dart';

import '../presentation/pages/home_page.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://ubjqvkvameebwmsjujbd.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVianF2a3ZhbWVlYndtc2p1amJkIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTkwNjIwNTUsImV4cCI6MjAxNDYzODA1NX0.C0T-L8L_T5ny_gL2Mm4RAQJ36-DtZDoByAbLAqPcymk',
  );
  WidgetsFlutterBinding.ensureInitialized();
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
          }
        },
        builder: (context, state) => const SplashPage(),
      ),
      routes: {
        WelcomePage.routeName: (context) => const WelcomePage(),
        RegisterPage.routeName: (context) => RegisterPage(),
        LoginPage.routeName: (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
        AddRoomPage.routeName: (context) => const AddRoomPage(),
        RoomDetailsScreen.routeName: (context) => const RoomDetailsScreen(),
      },
      navigatorKey: MyApp.navigatorKey,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: kFuriousRedColor,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
    );
  }
}
