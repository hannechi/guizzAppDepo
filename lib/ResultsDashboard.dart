import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzapp2/Functions/QuizServices.dart';
import 'package:quizzapp2/ListOfQuizes.dart';
import 'package:quizzapp2/UserRegistration.dart';
import 'package:quizzapp2/simplePlayerProvider.dart';

import 'adminProvider.dart';

class ResultsDashboard extends StatelessWidget {
  const ResultsDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    print(QuizServices().getQuizScore(
        Provider.of<AdminProvider>(context, listen: false)
            .adminLoged
            .toString()));

    print(Provider.of<AdminProvider>(context, listen: false).quizName);
    print(Provider.of<SimplePlayerProvider>(context, listen: false)
        .userEnAttente
        .quizName);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz Results',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: false,
        leading: Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ElevatedButton.icon(
                onPressed: () {
                  if (!Provider.of<AdminProvider>(context, listen: false)
                      .adminLoged) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UserRegistration()),
                        (route) => false);
                  } else {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => ListOfQuizes()),
                        (route) => false);
                  }
                },
                icon: Icon(
                  Icons.play_circle,
                  size: 30,
                ),
                label: Text(
                  "New Quiz",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                )),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (!Provider.of<AdminProvider>(context, listen: false)
                .adminLoged) ...[
              SizedBox(height: 20),
              Text(
                'Quiz name Leaderboard',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(
                            'Your Rank',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Player Name",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Spacer(),
                          Text(
                            'Points',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Consumer<SimplePlayerProvider>(
                          builder: (context, player, _) {
                        return Row(
                          children: <Widget>[
                            Text(
                              "*",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              player.userEnAttente.name,
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '${player.userEnAttente.score}',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ],
            SizedBox(height: 20),
            Text(
              'All leaderboard results',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Rank',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Name',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Text(
                          'Points',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    FutureBuilder(
                        future: QuizServices().getQuizScore(Provider.of<
                                    AdminProvider>(context, listen: false)
                                .adminLoged
                            ? Provider.of<AdminProvider>(context, listen: false)
                                .quizName
                            : Provider.of<SimplePlayerProvider>(context,
                                    listen: false)
                                .userEnAttente
                                .quizName),
                        builder: (context, snapshot) {
                          var res = snapshot.data as Map<String, dynamic>;
                          List<dynamic> theList =
                              res["players"] as List<dynamic>;
                          theList
                              .sort((a, b) => b['score'].compareTo(a['score']));
                          print(theList);
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: theList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Text(
                                      '${index + 1}',
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      theList.elementAt(index)["name"]!,
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      theList
                                          .elementAt(index)["score"]
                                          .toString(),
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ]),
                                ],
                              );
                            },
                          );
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
