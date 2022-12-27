import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/services/f_ads.dart';
import '/features/onboarding/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GoogleAdDisplay>(create: ((context) => GoogleAdDisplay())),
        BlocProvider<InterstitalAdCubit>(
            create: ((context) => InterstitalAdCubit())),
      ],
      child: MaterialApp(
        title: 'Ges pastQuestions',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Inter'),
        home: const SplashScreen(),
      ),
    );
  }
}
