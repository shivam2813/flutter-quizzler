import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
void main() {
  runApp(const Quizzler());
}
QuizBrain quizpage =QuizBrain();
class Quizzler extends StatelessWidget {
  const Quizzler({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:Scaffold(
        backgroundColor: Colors.grey.shade900,
        body:const SafeArea(child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: QuizPage(),
        ),
          
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
    List<Icon> scorekeeper=[];


    void checkanswer(bool useranswer)
    {
      bool correctanswer=quizpage.getquestionanswer();
      setState(() {
        if(quizpage.isfinished()==true)
          {
            Alert(context: context,type: AlertType.error,title: 'FINISHED',desc: 'You have attempted all the wuestions.').show();
            quizpage.reset();
            scorekeeper=[];
          }
        else{
      if(useranswer==correctanswer)
      {
        scorekeeper.add(Icon(Icons.check,color: Colors.green));
      }
      else{
        scorekeeper.add(Icon(Icons.close,color: Colors.red));
      }
      quizpage.nextquestion();
      quizpage.isfinished();
      };},);
    }
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
              quizpage.getquestionText(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white,
                fontSize: 25.0,
              ),
        ),
            ),
          ),),
        Expanded(

          child: Padding(
          padding: const EdgeInsets.all(15.0),
          child:TextButton(
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.red)),
            onPressed: (){
              checkanswer(true);
            } ,
            child: const Text(
              'True',
              style: TextStyle(
                color:Colors.black,
                fontSize: 20.0,
              ),
            ),
          )
        ),),
        Expanded(

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 15),
            child:TextButton(
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.yellow)),
              onPressed: (){
                checkanswer(false);
                },
              child: const Text(
                'False',
                style: TextStyle(
                  color:Colors.black,
                  fontSize: 20,
                ),
              ),
            )
        ),),
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}
