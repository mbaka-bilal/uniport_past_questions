import 'package:flutter/material.dart';

import '../../../utils/app_utils.dart';
import '../../../utils/appstyles.dart';

class BodyContent extends StatelessWidget {
  const BodyContent({Key? key, required this.pageIndex}) : super(key: key);

  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(
      height: 20,
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        (pageIndex == 0)
            ? Image.asset(AppImages.onBoardingImageA)
            : Image.asset(AppImages.onBoardingImageB),
        space,
        Text(
          (pageIndex == 0) ? 'Practice Ges questions' : 'Score Great Scores',
          style: TextStyles.semiBold(20, Colors.black),
        ),
        space,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor:
                  (pageIndex == 0) ? AppColors.purple : Colors.black,
              radius: 5,
            ),
            const SizedBox(
              width: 10,
            ),
            CircleAvatar(
              backgroundColor:
                  (pageIndex == 1) ? AppColors.purple : Colors.black,
              radius: 5,
            ),
          ],
        )
      ],
    );
  }
}
