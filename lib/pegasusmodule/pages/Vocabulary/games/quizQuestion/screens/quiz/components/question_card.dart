import 'package:sample2/pegasusmodule/pages/Vocabulary/games/quizQuestion/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:quiz_app/controllers/question_controller.dart';
// import 'package:quiz_app/models/Questions.dart';

// import '../../../../Vocabulary/games/quizQuestion/constants.dart';
import '../../../controllers/_question_controller.dart';
import '../../../models/_questions.dart';
import 'option.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    Key? key,
    // it means we have to pass this
    required this.question,
  }) : super(key: key);

  final Question question;

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
      padding: const EdgeInsets.all(kDefaultPadding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          SizedBox(
              height: 250,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ví dụ:',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.black),
                  ),
                  Text(
                    question.question,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    'Ghi chú:',
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: kBlackColor),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    question.note,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    question.mean,
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.grey),
                  ),
                ],
              )),
          // Container(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Text(
          //         question.question,
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 15,
          //             fontWeight: FontWeight.w900),
          //       )
          //       ],
          //     ),
          //   ),SizedBox(height: 10,)
          //   ,Container(
          //      child: Column(
          //       mainAxisAlignment: MainAxisAlignment.start,
          //       children: [
          //         Text(
          //         question.question,
          //         style: TextStyle(
          //             color: Colors.black,
          //             fontSize: 15,
          //             fontWeight: FontWeight.w900),
          //       )
          //       ],
          //     ),
          //   )

          // SizedBox(height: 5),//kDefaultPadding / 2
          ...List.generate(
            question.options.length,
            (index) => Option(
                index: index,
                text: question.options[index],
                press: () => _controller.checkAns(question, index)),
          ),
        ],
      ),
    );
  }
}
