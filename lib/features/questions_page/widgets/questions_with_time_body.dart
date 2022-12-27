import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../features/questions_page/widgets/time_finished_dialog.dart';
import '../../../services/f_ads.dart';
import '../../../services/f_database.dart';
import '../../../state/counter_cubit.dart';
import '../../../utils/appstyles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_radio_button.dart';

class BuildBody extends StatelessWidget {
  BuildBody({super.key});

  final future = FDatabase.fetchQuestions('ges100');
  final countDownTimerCubit = CountDownTimerCubit();
  int totalScore = 0;

  @override
  Widget build(BuildContext context) {
    countDownTimerCubit.stream.listen((event) {
      if (event == 0) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (builder) => customDialog(context: context));
      }
    });

    return LayoutBuilder(
        builder: (context, boxConstrants) => ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: boxConstrants.maxHeight,
              ),
              child: FutureBuilder(
                  future: future,
                  builder: (context, snapShot) {
                    if (snapShot.hasData) {
                      List<Map<String, dynamic>> questionsMap =
                          snapShot.data as List<Map<String, dynamic>>;
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlocBuilder<GoogleAdDisplay, BannerAd?>(
                                builder: ((context, state) {
                              context
                                  .read<GoogleAdDisplay>()
                                  .initializeBannerAd();
                              if (state != null) {
                                return SizedBox(
                                  width: state.size.width.toDouble(),
                                  height: state.size.height.toDouble(),
                                  child: AdWidget(
                                    ad: state,
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            })),
                            StreamBuilder(
                                stream: countDownTimerCubit.stream,
                                builder: (context, asyncSnapShot) {
                                  // int? data = asyncSnapShot.data;

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      LinearProgressIndicator(
                                        minHeight: 10,
                                        value: (asyncSnapShot.hasData)
                                            ? (asyncSnapShot.data! / 10)
                                            : 1,
                                        color: AppColors.purple,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.punch_clock_outlined,
                                            color: Colors.black45,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                              (asyncSnapShot.hasData)
                                                  ? '${asyncSnapShot.data}'
                                                  : '30',
                                              style: TextStyles.regular(
                                                  14, Colors.black45))
                                        ],
                                      )
                                    ],
                                  );
                                }),

                            //Begin questions and answer display
                            BlocBuilder<CounterCubit, int>(
                                builder: (context, state) {
                              String optionString =
                                  questionsMap[state]['options'];
                              List<String> options = optionString.split('|');

                              return Column(
                                children: [
                                  Text(
                                    'Question ${state + 1}/${questionsMap.length}',
                                    style:
                                        TextStyles.semiBold(20, Colors.black45),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            const SizedBox(
                                              height: 25,
                                            ),
                                            Text(
                                              questionsMap[state]['question'],
                                              style: TextStyles.medium(
                                                  20, Colors.black),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            ...List.generate(
                                                options.length,
                                                (index) => CustomRadioButton(
                                                    correctAnswerIndex: int
                                                        .tryParse(questionsMap[
                                                                state]
                                                            ['answerIndex'])!,
                                                    buttonIndex: index,
                                                    question: options[index]))
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                            //End question and answer display

                            //Begin display of buttons

                            BlocBuilder<CounterCubit, int>(
                              builder: (context, state) => Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20, right: 10, left: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomButton(
                                      function: (state == 0)
                                          ? null
                                          : () {
                                              context
                                                  .read<CounterCubit>()
                                                  .decrement();
                                              context
                                                  .read<CheckAnswerCubit>()
                                                  .updateStatus(false, 0);
                                              if (totalScore != 0) {
                                                totalScore--;
                                              }
                                            },
                                      width: 100,
                                      backgroundColor: Colors.white,
                                      child: Text(
                                        'Back',
                                        style: TextStyles.regular(
                                            14, Colors.black),
                                      ),
                                    ),
                                    CustomButton(
                                      function: () {
                                        if (state == questionsMap.length - 1) {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (builder) {
                                                print(
                                                    'the total score is $totalScore');
                                                return totalScoreDialog(
                                                    context: context,
                                                    totalScore: totalScore);
                                              });
                                        } else {
                                          context
                                              .read<CounterCubit>()
                                              .increment();
                                          int answerIndex = context
                                              .read<CheckAnswerCubit>()
                                              .viewStatus()
                                              .chosenAnswerIndex;
                                          if (answerIndex ==
                                              int.tryParse(questionsMap[state]
                                                  ['answerIndex'])) {
                                            totalScore++;
                                            print(
                                                "the total scrore is $totalScore");
                                          } else {
                                            if (totalScore != 0) {
                                              totalScore--;
                                              print(
                                                  "the total scrore is $totalScore");
                                            }
                                          }
                                        }
                                      },
                                      width: 100,
                                      backgroundColor: AppColors.purple,
                                      child: Text(
                                          (state == questionsMap.length - 1)
                                              ? 'Submit'
                                              : 'Next'),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            //End display of buttons
                          ],
                        ),
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ));
  }
}
