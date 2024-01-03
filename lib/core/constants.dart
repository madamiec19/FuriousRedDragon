import 'package:flutter/material.dart';
import 'package:furious_red_dragon/core/main.dart';
import 'package:gap/gap.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final client = Supabase.instance.client;

const kFuriousRedColor = Color.fromRGBO(193, 39, 38, 1);
const kPageBackgroundColor = Color.fromRGBO(243, 243, 243, 1);
const kLightGrey = Color.fromRGBO(217, 217, 217, 1);
const kDarkerGrey = Color.fromRGBO(177, 170, 170, 1);
const kGoodGreenColor = Color.fromRGBO(132, 228, 109, 1);

final kGlobalContext = MyApp.navigatorKey.currentContext;
final kScreenWidth = MediaQuery.of(kGlobalContext!).size.width;

EdgeInsets kSplashInputMargin =
    EdgeInsets.symmetric(horizontal: 0.12 * kScreenWidth);

const TextStyle kGlobalTextStyle =
    TextStyle(fontFamily: 'Lato', letterSpacing: 0.41);

const kButtonElevation = 2.0;

/// Creates a gap that has 10px.
const Widget kSmallGap = Gap(10);

/// Creates a gap that has 15px.
const Widget kMediumGap = Gap(15);

/// Creates a gap that has 20px.
const Widget kBigGap = Gap(20);

const kDragonLogoPath = 'assets/images/dragon.png';

InputDecoration kCredentialsTextFieldInputDecoration = InputDecoration(
  labelStyle: kGlobalTextStyle.copyWith(
    color: const Color.fromRGBO(177, 170, 170, 1),
    fontSize: 18,
  ),
  border: InputBorder.none,
  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  errorStyle: TextStyle(color: kFuriousRedColor),
);

TextStyle kCredentialsTextStyle = kGlobalTextStyle.copyWith(
  color: const Color.fromARGB(255, 2, 2, 2),
  fontSize: 18,
);

BoxDecoration kCredentialsTextFieldContainerDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(8),
  color: const Color.fromRGBO(255, 232, 232, 1),
  boxShadow: [
    BoxShadow(
      color: Colors.black.withOpacity(0.2),
      spreadRadius: 1,
      blurRadius: 3,
      offset: const Offset(0, 2),
    ),
  ],
);
