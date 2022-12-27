import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../features/questions_page/screens/questions_screen.dart';
import '../features/questions_page/screens/questions_screen_with_time.dart';
import '../utils/appstyles.dart';

Widget selectQuizTypeDialog(String tableName, BuildContext context) {
  return Dialog(
    child: Card(
      color: AppColors.purple,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InkWell(
              onTap: () {
                
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => QuestionScreenWithTime(
                          subjectName: tableName,
                        )));
              },
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const FaIcon(FontAwesomeIcons.stopwatch20,
                      color: Colors.white),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Real Time",
                    textAlign: TextAlign.start,
                    style: TextStyles.semiBold(
                      20,
                      Colors.white,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => PractiseQuestionScreen(
                          subjectName: tableName,
                        )));
              },
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  const FaIcon(
                    FontAwesomeIcons.ban,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    "Practise",
                    textAlign: TextAlign.start,
                    style: TextStyles.semiBold(
                      20,
                      Colors.white,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}
