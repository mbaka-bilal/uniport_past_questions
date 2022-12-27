import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class CounterCubit extends Cubit<int> {
  /// Class to handle current index of question to display
  ///
  ///
  CounterCubit() : super(0);

  //Add 1 to the current state
  void increment() => emit(state + 1);

  // Subtract 1 from the current state
  void decrement() => emit(state - 1);
}

class CheckAnswerCubit extends Cubit<CheckAnswer> {
  CheckAnswerCubit()
      : super(CheckAnswer(shouldCheckAnswer: false, chosenAnswerIndex: 0));

  void updateStatus(bool shouldCheckAnswer, int chosenAnswerIndex) {
    emit(CheckAnswer(
        shouldCheckAnswer: shouldCheckAnswer,
        chosenAnswerIndex: chosenAnswerIndex));
  }

  CheckAnswer viewStatus() {
    return state;
  }
}

class CheckAnswer {
  bool shouldCheckAnswer;
  int chosenAnswerIndex;

  CheckAnswer(
      {required this.shouldCheckAnswer, required this.chosenAnswerIndex});

  // set updateAnswerIndex(int index) {
  //   chosenAnswerIndex = index;
  // }

  // set updateShouldCheckAnswer(bool status) {
  //   shouldCheckAnswer = status;
  // }
}

class CountDownTimerCubit extends Cubit<int> {
  Timer? timer;

  CountDownTimerCubit() : super(31) {
    emit(30);
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (state == 0) {
        timer.cancel();
      } else {
        emit(state - 1);
      }
    });
  }

  @override
  Future<void> close() {
    timer ?? timer!.cancel();
    return super.close();
  }
}
