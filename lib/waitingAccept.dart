import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:quizzapp2/Functions/QuizServices.dart';
import 'package:quizzapp2/UserRegistration.dart';
import 'package:quizzapp2/playerInformationCard.dart';
import 'package:quizzapp2/simplePlayerProvider.dart';

import 'Functions/Database.dart';
import 'Models/UserEnAttente.dart';
import 'PlayQuiz.dart';
import 'UserCard.dart';
import 'login_screen.dart';

class WaitingAccept extends StatefulWidget {
  const WaitingAccept({super.key, required this.theIdOfUser});
  final String theIdOfUser;

  @override
  State<WaitingAccept> createState() => _WaitingAcceptState();
}

class _WaitingAcceptState extends State<WaitingAccept> {
  @override
  Widget build(BuildContext context) {
    String currentQuizPlaying =
        Provider.of<SimplePlayerProvider>(context, listen: false).currentQuiz;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Flutter quiz',
            style: TextStyle(color: Colors.white, fontSize: 25)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 0.0),
        child: Center(
          child: StreamBuilder(
              stream: DatabaseService().checkAcceptance(widget.theIdOfUser),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  bool isIn = snapshot.data as bool;

                  if (isIn == false) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamBuilder<Object>(
                            stream: DatabaseService()
                                .checkRefused(widget.theIdOfUser),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                bool r = snapshot.data as bool;
                                if (r == true) {
                                  Future.delayed(Duration(seconds: 1), () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "You are not accepted to play the quiz !"),
                                      behavior: SnackBarBehavior.floating,
                                      elevation: 15,
                                      backgroundColor: Colors.orange,
                                    ));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserRegistration()));
                                  });

                                  /*  showDialog<void>(
                                      context: context,
                                      barrierDismissible:
                                          false, // user must tap button!
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Center(
                                              child: Text(
                                                  'Quitter l\'application')),
                                          content: SingleChildScrollView(
                                            child: ListBody(
                                              children: const <Widget>[
                                                Text(
                                                    'Vous allez quitter l\'application ?'),
                                              ],
                                            ),
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                                child: const Text('Annuler',
                                                    style: TextStyle(
                                                        color: Colors.amber)),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                }),
                                          ],
                                        );
                                      }); */
                                }
                              }
                              return Container();
                            }),
                        Text(
                          "Waiting for admin to accept you in the quiz ",
                          style: TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        /* Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SpinKitFadingCube(
                                color: Colors.deepPurple,
                                size: 50.0,
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                "Please wait admin Authorisation",
                                style: TextStyle(fontSize: 20.0),
                              ),
                            ],
                          ),
                        ), */
                        SizedBox(
                            height: 150,
                            width: 150,
                            child: CircularProgressIndicator(
                              color: Colors.deepPurple,
                              strokeWidth: 8.0,
                            )),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        StreamBuilder<Object>(
                            stream: QuizServices().guardQuiz(
                                Provider.of<SimplePlayerProvider>(context,
                                        listen: false)
                                    .currentQuiz),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                int a = snapshot.data as int;
                                if (a == 0) {
                                  Future.delayed(Duration(seconds: 1), () {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(const SnackBar(
                                      content: Text(
                                          "the quiz  started you need to play!"),
                                      behavior: SnackBarBehavior.floating,
                                      elevation: 15,
                                      backgroundColor: Colors.orangeAccent,
                                    ));
                                  });
                                }
                              }
                              return Container();
                            }),
                        StreamBuilder<Object>(
                            stream: QuizServices()
                                .getPlayersInQuiz(currentQuizPlaying),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                              if (snapshot.hasData) {
                                List<dynamic> res =
                                    snapshot.data as List<dynamic>;
                                print(res);
                                //return Text(res.length.toString());
                                return ListView.builder(
                                    physics: ScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: res.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      /*  return Text(
                                  UserEnAttente.fromMap(res[index]).toString()); */

                                      return PlayerInformationCard(
                                          user: UserEnAttente.fromMap(
                                              res[index]));
                                    });
                              }
                              return SizedBox();
                            }),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.play_arrow),
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.grey, width: 0.3),
                                    borderRadius: BorderRadius.circular(50)),
                                minimumSize: Size(100, 50)),
                            label: Text("Play", style: TextStyle(fontSize: 18)),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PlayQuiz(idQuiz: currentQuizPlaying),
                                  ));
                            },
                          ),
                        ),
                      ],
                    );
                  }
                }
                return Text("out");
              }),
        ),
      ),
    );
  }
}
