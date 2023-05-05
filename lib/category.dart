import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Models/Question.dart';
import 'adminProvider.dart';
import 'PlayQuiz.dart';
import 'science.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key, this.title = ""}) : super(key: key);
  final String title;

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<Question> resFromProvider = List.empty(growable: true);
  @override
  void initState() {
    // TODO: implement initState
    resFromProvider =
        Provider.of<AdminProvider>(context, listen: false).QuizQuestions;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
        backgroundColor: Colors.indigo,
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(20),
              width: double.infinity,
              height: 205,
              child: ElevatedButton(
                child: Text('PLAY ARTS QUIZ'),
                onPressed: () {
                  /*   Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ArtsPage()),
                  ); */
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
