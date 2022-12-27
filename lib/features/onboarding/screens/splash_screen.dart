import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uniport_past_questions/features/onboarding/screens/onboarding.dart';
import 'package:uniport_past_questions/services/f_database.dart';

import '../../../utils/appstyles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _initialize() async {
    FDatabase fDatabase = FDatabase();
    var nav = Navigator.of(context);
    if (await fDatabase.checkIfTableExists('ges100') == false) {
      await FDatabase.createDatabaseAndTables('ges100');
      await fDatabase.addQuestionsToTable('ges100');
    }
    nav.pushReplacement(
        MaterialPageRoute(builder: (context) => const OnBoarding()));
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.alabaster,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(),
            const CupertinoActivityIndicator(
              color: Colors.black,
            )
          ],
        ));
  }
}
