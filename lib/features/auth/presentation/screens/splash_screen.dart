import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../app/constants.dart';
import '../../../../core/database/cache_helper.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../features/auth/presentation/screens/on_boarding_screen.dart';
import '../../../../features/task/presentation/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigate() {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      dynamic onBoardingToken =
          sl<CacheHelper>().getData(key: Constants.onBoardingKey);
      if (onBoardingToken != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomeScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (_) => const OnBoardingScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppAssets.logo,
            ),
            Text(AppStrings.uptodo,
                style: GoogleFonts.lato(
                  color: AppColors.white,
                  fontSize: FontSize.s40,
                  fontWeight: FontWeight.w700,
                )),
          ],
        ),
      ),
    );
  }
}
