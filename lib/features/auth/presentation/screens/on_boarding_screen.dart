import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../../core/database/cache_helper.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../features/auth/presentation/cubit/on_boarding_cubit.dart';
import '../../../../features/task/presentation/screens/home_screen.dart';
import '../../../../app/constants.dart';
import '../cubit/on_boarding_states.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingStates>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.black,
          appBar: AppBar(
            backgroundColor: AppColors.black,
            elevation: 0.0,
          ),
          body: Center(
            child: buildBody(),
          ),
        );
      },
    );
  }


  buildBody() {
    return PageView.builder(
      controller: BlocProvider.of<OnBoardingCubit>(context).pageController,
      itemCount:
          BlocProvider.of<OnBoardingCubit>(context).onBoardingList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 37,
          ),
          child: Column(
            children: [
              // picture
              buildSvgPic(index),
              SizedBox(
                height: 16.h,
              ),
              // page indicator
              buildIndicator(),
              SizedBox(
                height: 40.h,
              ),
              // on boarding title
              buildTitle(index),
              SizedBox(
                height: 42.h,
              ),
              // on boarding sub title
              buildSubTitle(index),
              const Spacer(),
              // traverse buttons
              buildTraverseButtons(index)
            ],
          ),
        );
      },
    );
  }

  buildSvgPic(index) {
    return SvgPicture.asset(
      BlocProvider.of<OnBoardingCubit>(context).onBoardingList[index].image,
      width: 300,
      height: 300,
    );
  }

  buildIndicator() {
    return SmoothPageIndicator(
      controller: BlocProvider.of<OnBoardingCubit>(context).pageController,
      count: 3,
      effect: ExpandingDotsEffect(
        dotColor: AppColors.gray,
        activeDotColor: AppColors.white87,
        dotHeight: 5.0,
        dotWidth: 16.0,
      ),
    );
  }

  buildTitle(int index) {
    return Text(
      BlocProvider.of<OnBoardingCubit>(context).onBoardingList[index].title,
      style: GoogleFonts.lato(
          color: AppColors.white87,
          fontSize: FontSize.s24,
          fontWeight: FontWeight.w700),
    );
  }

  buildSubTitle(int index) {
    return RichText(
      text: TextSpan(
        text: BlocProvider.of<OnBoardingCubit>(context)
            .onBoardingList[index]
            .subTitle,
        style: GoogleFonts.lato(
            color: AppColors.gray,
            fontSize: FontSize.s16,
            fontWeight: FontWeight.w400),
      ),
      textAlign: TextAlign.center,
    );
  }

  buildTraverseButtons(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(
        children: [
          // back button
          index != 0
              ? TextButton(
                  onPressed: () {
                    BlocProvider.of<OnBoardingCubit>(context).prevPage();
                  },
                  child: Text(
                    AppStrings.back,
                    style: GoogleFonts.lato(
                        color: AppColors.white44,
                        fontSize: FontSize.s16,
                        fontWeight: FontWeight.w400),
                  ),
                )
              : Container(),
          const Spacer(),
          // next button
          index != 2
              ? ElevatedButton(
                  onPressed: () {
                    BlocProvider.of<OnBoardingCubit>(context).nextPage();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.offBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Text(
                    AppStrings.next,
                    style: GoogleFonts.lato(
                        color: AppColors.white87,
                        fontSize: FontSize.s16,
                        fontWeight: FontWeight.w400),
                  ),
                )
              : ElevatedButton(
                  onPressed: () async {
                    await sl<CacheHelper>()
                        .saveData(key: Constants.onBoardingKey, value: true)
                        .then((value) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const HomeScreen()));
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.offBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                  child: Text(
                    AppStrings.getStarted,
                    style: GoogleFonts.lato(
                        color: AppColors.white87,
                        fontSize: FontSize.s16,
                        fontWeight: FontWeight.w400),
                  ),
                )
        ],
      ),
    );
  }
}
