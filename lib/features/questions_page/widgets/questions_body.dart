import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

import '../../../services/f_ads.dart';
import '../../../services/f_database.dart';
import '../../../state/counter_cubit.dart';
import '../../../utils/appstyles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_radio_button.dart';

class Body extends StatelessWidget {
  /// Body of the quiz without timer
  ///
  ///

  //TODO input to select course table

  Body({
    Key? key,
  }) : super(key: key);

  Future<List<Map<String, dynamic>>> future =
      FDatabase.fetchQuestions('ges100');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapShot) {
          if (snapShot.hasData) {
            List<Map<String, dynamic>> questionsMap =
                snapShot.data as List<Map<String, dynamic>>;

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //Begin questions and answer display
                  BlocBuilder<CounterCubit, int>(builder: (context, state) {
                    String optionString = questionsMap[state]['options'];
                    List<String> options = optionString.split('|');

                    return Column(
                      children: [
                        BlocBuilder<GoogleAdDisplay, BannerAd?>(
                            builder: ((context, state) {
                          context.read<GoogleAdDisplay>().initializeBannerAd();
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
                        Text(
                          'Question ${state + 1}/${questionsMap.length}',
                          style: TextStyles.semiBold(20, Colors.black45),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height / 2,
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    questionsMap[state]['question'],
                                    style: TextStyles.medium(20, Colors.black),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ...List.generate(
                                      options.length,
                                      (index) => CustomRadioButton(
                                          correctAnswerIndex: int.tryParse(
                                              questionsMap[state]
                                                  ['answerIndex'])!,
                                          buttonIndex: index,
                                          question: options[index]))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                  //End question and answer display

                  //Begin the logic to show button and answer icon

                  BlocBuilder<CheckAnswerCubit, CheckAnswer>(
                      builder: (context, state) {
                    final Widget displayIcon;

                    if (state.shouldCheckAnswer) {
                      if (((questionsMap[context.read<CounterCubit>().state]
                                  ['answerIndex'])
                              .toString() ==
                          (state.chosenAnswerIndex).toString())) {
                        displayIcon = const FaIcon(
                          FontAwesomeIcons.check,
                          color: Colors.green,
                        );
                      } else {
                        displayIcon = const FaIcon(
                          FontAwesomeIcons.xmark,
                          color: Colors.red,
                        );
                      }
                    } else {
                      displayIcon = Container();
                    }

                    return Column(
                      children: [
                        displayIcon,
                        //choose to display the Back - Next button or checkAnswer button
                        (state.shouldCheckAnswer)
                            ? BlocBuilder<CounterCubit, int>(
                                builder: ((context, state) => Padding(
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
                                                        .read<
                                                            CheckAnswerCubit>()
                                                        .updateStatus(false, 0);
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
                                            function: (state ==
                                                    questionsMap.length - 1)
                                                ? null
                                                : () {
                                                    context
                                                        .read<CounterCubit>()
                                                        .increment();
                                                    context
                                                        .read<
                                                            CheckAnswerCubit>()
                                                        .updateStatus(false, 0);
                                                  },
                                            width: 100,
                                            backgroundColor: AppColors.purple,
                                            child: const Text('Next'),
                                          ),
                                        ],
                                      ),
                                    )))
                            : Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 20, right: 10, left: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomButton(
                                      function: () {
                                        context
                                            .read<CheckAnswerCubit>()
                                            .updateStatus(
                                                true,
                                                context
                                                    .read<CheckAnswerCubit>()
                                                    .state
                                                    .chosenAnswerIndex);
                                      },
                                      width: 200,
                                      backgroundColor: AppColors.purple,
                                      child: const Text('Check Answer'),
                                    ),
                                  ],
                                ),
                              )
                      ],
                    );
                  }),
                  //End the logic to show button and answer icon
                ],
              ),
            );
          } else {
            return const CircularProgressIndicator();
          }
        });
  }
}
