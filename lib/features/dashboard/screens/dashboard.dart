import 'package:flutter/material.dart';

import '../../../features/dashboard/screens/choose_subject.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/appstyles.dart';
import '../../../widgets/custom_button.dart';

class DashBoard extends StatelessWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, boxConstraints) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Image.asset(AppImages.dashboardImage),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Past Questions',
                style: TextStyles.semiBold(20, Colors.black),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                function: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ChooseSubject()));
                },
                width: boxConstraints.maxWidth / 2,
                backgroundColor: AppColors.purple,
                child: Text(
                  'Start test',
                  style: TextStyles.regular(14, Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
