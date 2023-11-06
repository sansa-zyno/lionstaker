import 'package:flutter/material.dart';
import 'package:social_betting_predictions/model/onboarding_model.dart';

class OnboardingProvider extends ChangeNotifier {
  int selectedPageIndex = 0;
  //bool get isLastPage => selectedPageIndex.value == onBoardingList.length - 1;
  var pageController = PageController();
  List<OnboardingModel> onBoardingList = [
    OnboardingModel("assets/ls_onboarding-1.jpg", "GROW YOUR EARNINGS EASILY",
        "Invite your friends and earn through referral bonus"),
    OnboardingModel("assets/ls_onboarding-2.jpg", "CONNECT WITH FELLOW GAMERS",
        "Join a community of passionate gamers"),
    OnboardingModel("assets/lstakers-3.png", "STAY UPDATED WITH LATEST NEWS",
        "Never miss a beat of real-time updates and livescores"),
  ];

  setPage(int i) {
    selectedPageIndex = i;
    notifyListeners();
  }
}
