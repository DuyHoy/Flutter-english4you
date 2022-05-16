import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:quiz_app/controllers/question_controller.dart';

// import '../../constants.dart';
import '../../controllers/_question_controller.dart';
import 'components/body.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuestionController _controller = Get.put(QuestionController());
    return  
    Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Obx(
                  () => Text.rich(
                    TextSpan(
                      text:
                          "Question ${_controller.questionNumber.value}",
                      style: Theme.of(context)
                          .textTheme
                          .headline5
                          ?.copyWith(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "/${_controller.questions.length}",
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              ?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
        // Fluttter show the back button automatically
        backgroundColor: Colors.blue,
        elevation: 0,
        // leadingWidth: 100,
        // leading: Builder(builder: (BuildContext context){
        //   return FlatButton(onPressed: _controller.previousQuestion, child: Text("Previous"));
        // }),
        // actions: [ FlatButton(onPressed: _controller.nextQuestion, child: Text("Skip"))],
      ),
      body: const Body(),
    );
  }
}
