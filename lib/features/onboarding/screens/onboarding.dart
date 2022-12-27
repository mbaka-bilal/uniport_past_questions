import 'dart:async';

import 'package:flutter/material.dart';

import '../../dashboard/screens/dashboard.dart';
import '../widgets/body_content.dart';

import '/utils/appstyles.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late Timer _timer;
  final _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_pageController.page == 1) {
        _pageController.previousPage(
            duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      } else {
        _pageController.nextPage(
            duration: const Duration(seconds: 1), curve: Curves.easeInOut);
      }
    });
  }

  @override
  void dispose() {
    if (_timer.isActive) {
      _timer.cancel();
    }
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const DashBoard()));
                  },
                  child: Text(
                    "Next",
                    style: TextStyles.medium(14, AppColors.purple),
                  ),
                ),
              ),
              Expanded(
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  controller: _pageController,
                  children: List.generate(
                      2, (index) => BodyContent(pageIndex: index)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
