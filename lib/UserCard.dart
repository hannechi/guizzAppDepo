import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:quizzapp2/Functions/QuizServices.dart';
import 'package:quizzapp2/Models/QuizModel.dart';
import 'package:quizzapp2/PlayQuiz.dart';

import 'Models/UserEnAttente.dart';
import 'category.dart';
import 'listUsersEnattenteAdmin.dart';

class UserEnAttenteCard extends StatefulWidget {
  const UserEnAttenteCard({super.key, required this.user});
  final UserEnAttente user;

  @override
  State<UserEnAttenteCard> createState() => _UserEnAttenteCardState();
}

class _UserEnAttenteCardState extends State<UserEnAttenteCard> {
  String rep = "not yet";
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.user.name,
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 20)),
              ),
              rep == "not yet"
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          ElevatedButton(
                              child: Text("Accept"),
                              onPressed: () {
                                // add the user the wanted quiz
                                QuizServices().addUserToQuiz(widget.user);
                                rep = "accepted";
                                setState(() {});
                              }),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey.shade600),
                            child: Text("Decline"),
                            onPressed: () {
                              rep = "refused";
                              setState(() {});
                              /*  Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UsersEnAttenteInAdmin(
                                  QuizId: user.quizId,
                                ),
                              )); */
                              /*  Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PlayQuiz(
                                        idQuiz: quiz.quizId,
                                      )),
                              (route) => false); */
                            },
                          ),
                        ],
                      ),
                    )
                  : rep == "accepted"
                      ? Text(
                          "Accepted ",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.w500),
                        )
                      : Text(
                          "Refused",
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
