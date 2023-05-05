import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:quizzapp2/Functions/QuizServices.dart';
import 'package:quizzapp2/Models/QuizModel.dart';
import 'package:quizzapp2/PlayQuiz.dart';

import 'Models/UserEnAttente.dart';
import 'category.dart';
import 'listUsersEnattenteAdmin.dart';

class PlayerInformationCard extends StatefulWidget {
  const PlayerInformationCard({super.key, required this.user});
  final UserEnAttente user;

  @override
  State<PlayerInformationCard> createState() => _PlayerInformationCardState();
}

class _PlayerInformationCardState extends State<PlayerInformationCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://e7.pngegg.com/pngimages/911/5/png-clipart-computer-icons-icon-design-anonymous-avatar-anonymous-face-smiley.png"),
              ),
              SizedBox(
                width: 35,
              ),
              Text(widget.user.name, style: TextStyle(fontSize: 25))
            ],
          ),
        ),
      ),
    );
  }
}
