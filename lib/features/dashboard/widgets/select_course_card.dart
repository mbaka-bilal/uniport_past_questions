import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../services/f_ads.dart';
import '../../../services/f_database.dart';
import '../../../utils/appstyles.dart';
import '../../../widgets/quiz_type_dialog.dart';

class SelectCourseCard extends StatelessWidget {
  /// Widget to display the card to select the course to work on
  /// tableName is to define the table to read so the number of questions can
  /// be counted and displayed.
  ///

  const SelectCourseCard(
      {Key? key,
      required this.leadingWidget,
      required this.courseName,
      required this.tableName})
      : super(key: key);

  final Widget leadingWidget;
  final String courseName;
  final String tableName;

  @override
  Widget build(BuildContext context) {
    const space = SizedBox(
      height: 10,
    );

    return BlocBuilder<InterstitalAdCubit, InterstitialAd?>(
      builder: (context, state) => InkWell(
        onTap: () {
          context.read<InterstitalAdCubit>().loadInterstitialAd();
          if (state != null) {
            state.show();
          }
          showDialog(
              context: context,
              builder: (context) => selectQuizTypeDialog(tableName, context));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          width: double.infinity,
          // height: 100,
          child: Card(
            // margin: EdgeInsets.symmetric(vertical: 10),
            color: AppColors.purple,
            // margin: EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white60,
                    ),
                    padding: const EdgeInsets.all(10),
                    child: leadingWidget,
                  ),
                  space,
                  Text(
                    courseName,
                    style: TextStyles.semiBold(20, Colors.white),
                  ),
                  space,
                  FutureBuilder(
                      future: FDatabase.countQuestions('ges100'),
                      builder: ((context, snapshot) {
                        if (snapshot.hasData) {
                          int result = snapshot.data as int;
                          return Text(
                            'Pool: $result Questions',
                            style: TextStyles.regular(14, Colors.white),
                          );
                        } else {
                          return Container();
                        }
                      })),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
