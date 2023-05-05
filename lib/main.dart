import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzapp2/Functions/QuizServices.dart';

import 'package:quizzapp2/adminProvider.dart';
import 'package:quizzapp2/login_screen.dart';
import 'package:quizzapp2/simplePlayerProvider.dart';
import 'package:quizzapp2/waitingAccept.dart';
//import 'science.dart';
import 'ListOfQuizes.dart';
import 'Models/QuizModel.dart';
import 'ResultsDashboard.dart';
import 'UserRegistration.dart';
import 'WelcomeScreen.dart';
import 'addQuizStep1.dart';
import 'addQuizStep2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAN3cYClyeBKWYtCn2UDRK3TU0ILl4ivTQ",
          appId: "1:428913673008:android:a23ef72016ce59d163bef5",
          messagingSenderId:
              "428913673008-qrfchsnuq76k8jcil55ph5es56odpslg.apps.googleusercontent.com",
          projectId: "tempquiz-1707c"));
/*   String smth = QuizServices.generateRandomId();
  QuizServices().addNewQuiz(
      smth,
      Quiz(quizName: "quizName", quizId: smth, questions: [
        {"q": "qgsdhq ?", "r": true}
      ], players: [
        {"userName": "ala ?", "score": 20}
      ])); */
/*   print("Data y m3lem");
  print(await QuizServices().getQuestionsOfQuiz("32479161")); */
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AdminProvider adminProvider = AdminProvider();
    SimplePlayerProvider playerProvider = SimplePlayerProvider();
    return MultiProvider(
      providers: [
        ListenableProvider<AdminProvider>(
          create: (context) => adminProvider,
        ),
        ListenableProvider<SimplePlayerProvider>(
          create: (context) => playerProvider,
        )
      ],
      child: MaterialApp(
          title: 'Flutter Quiz',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: LoadingPage()),
    );
  }
}
