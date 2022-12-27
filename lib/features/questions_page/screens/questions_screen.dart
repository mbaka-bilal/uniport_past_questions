import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../state/counter_cubit.dart';
import '../../../utils/appstyles.dart';
import '../widgets/questions_body.dart';

class PractiseQuestionScreen extends StatelessWidget {
  const PractiseQuestionScreen({
    super.key,
    required this.subjectName,
  });

  final String subjectName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.alabaster,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Colors.transparent,
        title: Text(
          subjectName,
          style: TextStyles.regular(14, Colors.black),
        ),
      ),
      body: MultiBlocProvider(providers: [
        BlocProvider<CounterCubit>(
          create: (_) => CounterCubit(),
        ),
        BlocProvider<CheckAnswerCubit>(
          create: (_) => CheckAnswerCubit(),
        ),
        BlocProvider<CountDownTimerCubit>(
          create: (_) => CountDownTimerCubit(),
        ),
      ], child: Body()),
    );
  }
}
