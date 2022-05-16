// ignore_for_file: deprecated_member_use

import 'package:sample2/pegasusmodule/pages/Vocabulary/games/quizQuestion/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:quiz_app/constants.dart';
// import 'package:quiz_app/controllers/question_controller.dart';
// import 'package:quiz_app/models/Questions.dart';
// import 'package:flutter_svg/svg.dart';

// import '../../../../Vocabulary/games/quizQuestion/constants.dart';
import '../../../controllers/_question_controller.dart';
// import 'progress_bar.dart';
import 'question_card.dart';

class Body extends StatelessWidget {
  const Body({
    Key? key,
  }) : super(key: key);
// QuestionController _controller = Get.put(QuestionController());
  @override
  Widget build(BuildContext context) {
    // So that we have acccess our controller
    QuestionController _questionController = Get.put(QuestionController());
    return Stack(
      children: [
        // SvgPicture.asset("assets/icons/bg.svg", fit: BoxFit.fill),
        SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // SizedBox(height: kDefaultPadding),
              // Padding(
              //   padding:const EdgeInsets.symmetric(horizontal: kDefaultPadding),//
              //   child: ProgressBar(),
              // ),
              // SizedBox(height: kDefaultPadding),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding ),
              //   child: Obx(
              //     () => Text.rich(
              //       TextSpan(
              //         text:
              //             "Question ${_questionController.questionNumber.value}",
              //         style: Theme.of(context)
              //             .textTheme
              //             .headline5
              //             ?.copyWith(color: kSecondaryColor),
              //         children: [
              //           TextSpan(
              //             text: "/${_questionController.questions.length}",
              //             style: Theme.of(context)
              //                 .textTheme
              //                 .headline5
              //                 ?.copyWith(color: kSecondaryColor),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              const Divider(thickness: 1.5),
              const SizedBox(height: kDefaultPadding / 2),
              Expanded(
                child: PageView.builder(
                  // Block swipe to next qn
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _questionController.pageController,
                  onPageChanged: _questionController.updateTheQnNum,
                  itemCount: _questionController.questions.length,
                  itemBuilder: (context, index) => QuestionCard(
                      question: _questionController.questions[index]),
                ),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: FlatButton(
                        onPressed: _questionController.previousQuestion,
                        child: const Text("Previous")),
                  ),
                  Expanded(
                    // ignore: prefer_const_constructors
                    child: FlatButton(
                        onPressed: _questionController.nextQuestion,
                        child: Text("Next")),
                  ),
                ],
              )
            ],
          ),
        )
        // leading: Builder(builder: (BuildContext context){
        //   return FlatButton(onPressed: _controller.previousQuestion, child: Text("Previous"));
        // }),
        // actions: [ FlatButton(onPressed: _controller.nextQuestion, child: Text("Skip"))],
      ],
    );
  }
}
