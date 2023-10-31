
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/cubit/on_boarding_states.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_string.dart';
import '../../data/model/on_boarding_model.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit() : super(OnBoardingInitState());

  final PageController pageController = PageController();
  //double tracker = 0.0;
  List<OnBoardingModel> onBoardingList = [
    OnBoardingModel(
        image: AppAssets.on1,
        title: AppStrings.onBoard1Title,
        subTitle: AppStrings.onBoard1SubTitle),
    OnBoardingModel(
        image: AppAssets.on2,
        title: AppStrings.onBoard2Title,
        subTitle: AppStrings.onBoard2SubTitle),
    OnBoardingModel(
        image: AppAssets.on3,
        title: AppStrings.onBoard3Title,
        subTitle: AppStrings.onBoard3SubTitle),
  ];


  
  prevPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
    log(pageController.page.toString());
  }

  nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastEaseInToSlowEaseOut,
    );
    log(pageController.page.toString());
  }
}
