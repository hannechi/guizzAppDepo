// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:quizzapp2/Models/UserEnAttente.dart';

import 'Functions/QuizServices.dart';
import 'Models/QuizModel.dart';
import 'PlayQuiz.dart';
import 'QuizCard.dart';
import 'UserCard.dart';
import 'addQuizStep1.dart';

class UsersEnAttenteInAdmin extends StatefulWidget {
  final String QuizId;
  const UsersEnAttenteInAdmin({
    Key? key,
    required this.QuizId,
  }) : super(key: key);

  @override
  State<UsersEnAttenteInAdmin> createState() => _UsersEnAttenteInAdminState();
}

class _UsersEnAttenteInAdminState extends State<UsersEnAttenteInAdmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        title: const Text("Users en attente for Quiz",
            style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {});
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FutureBuilder<Object>(
                        future: QuizServices()
                            .getUsersEnAttenteForQuiz(widget.QuizId),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          }
                          if (snapshot.hasData) {
                            List<dynamic> res = snapshot.data as List<dynamic>;
                            print(res);
                            //return Text(res.length.toString());
                            return ListView.builder(
                                physics: ScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: res.length,
                                itemBuilder: (BuildContext context, int index) {
                                  /*  return Text(
                                      UserEnAttente.fromMap(res[index]).toString()); */

                                  return UserEnAttenteCard(
                                      user: UserEnAttente.fromMap(res[index]));
                                });
                          }
                          return SizedBox();
                        }),
                  ],
                ),
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
                    label: Text("Start quiz", style: TextStyle(fontSize: 18)),
                    onPressed: () {
                      QuizServices().startQuiz(widget.QuizId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PlayQuiz(
                                  idQuiz: widget.QuizId,
                                )),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
