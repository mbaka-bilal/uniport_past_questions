import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../state/counter_cubit.dart';
import '../utils/appstyles.dart';

class CustomRadioButton extends StatelessWidget {
  /// Class to handle question options
  ///
  ///
  const CustomRadioButton(
      {super.key,
      required this.buttonIndex,
      required this.question,
      required this.correctAnswerIndex});

  final int buttonIndex;
  final String question;
  final int correctAnswerIndex;

  @override
  Widget build(BuildContext context) {
    Color color = AppColors.alabaster;

    return BlocBuilder<CheckAnswerCubit, CheckAnswer>(
      builder: (context, state) {
       
        //choose the correct color
        if (state.shouldCheckAnswer) {
          if (correctAnswerIndex.toString() == buttonIndex.toString()) {
            color = Colors.purple;
          } else {
            color = Colors.red;
          }
        } else {
          if (state.chosenAnswerIndex == buttonIndex) {
            color = AppColors.purple;
          } else {
            color = AppColors.alabaster;
          }
        }

        return GestureDetector(
          onTap: (() {
            if (state.shouldCheckAnswer) {
              null;
            } else {
              context.read<CheckAnswerCubit>().updateStatus(false, buttonIndex);
            }
          }),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            decoration: BoxDecoration(
                color: color,
                border: Border.all(color: Colors.black26),
                borderRadius: BorderRadius.circular(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    question,
                    style: TextStyles.medium(14, Colors.black),
                  ),
                ),
                
              ],
            ),
          ),
        );
      },
    );
  }
}
