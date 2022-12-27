import 'package:flutter/material.dart';

import '/features/dashboard/screens/choose_subject.dart';
import '/widgets/custom_button.dart';

Widget customDialog({required BuildContext context}) {
  return WillPopScope(
    onWillPop: (() => Future.value(false)),
    child: AlertDialog(
      title: const Text('Time finished'),
      actions: [
        CustomButton(
            function: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ChooseSubject()),
                  (route) => false);
            },
            width: double.infinity,
            child: const Text("Okay"))
      ],
    ),
  );
}

Widget totalScoreDialog(
    {required BuildContext context, required int totalScore}) {
  return WillPopScope(
    onWillPop: (() => Future.value(false)),
    child: AlertDialog(
      title: const Text('Total Score'),
      actions: [
        CustomButton(
            function: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => ChooseSubject()),
                  (route) => false);
            },
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [Text("You scored: $totalScore")],
            ))
      ],
    ),
  );
}
