import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:quizzapp2/Functions/QuizServices.dart';
import 'package:quizzapp2/Models/QuizModel.dart';
import 'package:quizzapp2/UserRegistration.dart';
import 'package:quizzapp2/adminProvider.dart';

import 'QuestionCard.dart';
import 'QuizCard.dart';
import 'addQuizStep1.dart';

class ListOfQuizes extends StatelessWidget {
  const ListOfQuizes({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout),
          iconSize: 35,
          onPressed: () {
            Provider.of<AdminProvider>(context, listen: false).adminidLoging();
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => UserRegistration()),
                (route) => false);
          },
        ),
        centerTitle: true,
        title: const Text("My Quizes",
            style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<Object>(
                  future: QuizServices().getAllSavedQuiz(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasData) {
                      List<Quiz> res = snapshot.data as List<Quiz>;
                      return ListView.builder(
                          physics: ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: res.length,
                          itemBuilder: (BuildContext context, int index) {
                            return QuizCard(quiz: res[index]);
                          });
                    }
                    return SizedBox();
                  }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddQuizStep1()),
          );
        },
        label: const Text("New Quiz", style: TextStyle(fontSize: 18)),
        icon: const Icon(
          Icons.add,
          size: 35,
        ),
        backgroundColor: Colors.deepPurple[400],
      ),
    );
  }
}
