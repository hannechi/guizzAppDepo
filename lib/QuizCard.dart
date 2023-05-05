import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:quizzapp2/Models/QuizModel.dart';
import 'package:quizzapp2/PlayQuiz.dart';

import 'adminProvider.dart';
import 'category.dart';
import 'listUsersEnattenteAdmin.dart';

class QuizCard extends StatelessWidget {
  const QuizCard({super.key, required this.quiz});
  final Quiz quiz;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              title: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                child: Row(
                  children: [
                    Text(
                      "code: ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "${quiz.quizId}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              subtitle: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                child: Row(
                  children: [
                    Text(
                      "name: ",
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      "${quiz.quizName}",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              trailing: ElevatedButton.icon(
                icon: Icon(Icons.play_arrow),
                style: ElevatedButton.styleFrom(minimumSize: Size(80, 35)),
                label: Text("Play", style: TextStyle(fontSize: 15)),
                onPressed: () {
                  Provider.of<AdminProvider>(context, listen: false).quizName =
                      quiz.quizId;

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UsersEnAttenteInAdmin(
                          QuizId: quiz.quizId,
                        ),
                      ));
                  /*  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayQuiz(
                                idQuiz: quiz.quizId,
                              )),
                      (route) => false); */
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
