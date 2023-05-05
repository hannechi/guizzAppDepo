import 'package:quizzapp2/login_screen.dart';
import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';


class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  TextEditingController? firstNameInputController;
  TextEditingController? lastNameInputController;
  TextEditingController? emailInputController;
  TextEditingController? pwdInputController;
  TextEditingController? confirmPwdInputController;
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // CollectionReference? collectionReference; 
  // final Query users = FirebaseFirestore.instance.collectionGroup("users");
 
  @override
  initState() {
    firstNameInputController = new TextEditingController();
    lastNameInputController = new TextEditingController();
    emailInputController = new TextEditingController();
    pwdInputController = new TextEditingController();
    confirmPwdInputController = new TextEditingController();
    super.initState();
  }

  
 String? emailValidator(String? value) {
      String pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = new RegExp(pattern);
      if (!regex.hasMatch(value ?? "")) {
        return 'Email format is invalid';
      } else {
        return '';
      }
    }

  String? pwdValidator(String? value) {
    if (value!.length < 8) {
      return 'Password must be longer than 8 characters';
    } else {
      return '';
    }
  }

  String? nameValidator(String? value){
    if(value!.length<3){
      return'Minimum 4 characters!';
    }else{
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
        appBar: AppBar(
          title: Text("Register"),
        ),
        body: Container(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
                child: Form(
              key: _registerFormKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'First Name:'),
                    controller: firstNameInputController,
                    validator: nameValidator,
                  ),
                  TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Last Name:'),
                      controller: lastNameInputController,
                      validator: nameValidator
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Email:'),
                    controller: emailInputController,
                    keyboardType: TextInputType.emailAddress,
                    validator: emailValidator,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Password:'),
                    controller: pwdInputController,
                    obscureText: true,
                    validator: pwdValidator,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                        labelText: 'Confirm Password:'),
                    controller: confirmPwdInputController,
                    obscureText: true,
                    validator: pwdValidator,
                  ),
                  MaterialButton(
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    hoverColor: Colors.white,
                    elevation: 9.0,
                     minWidth: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      child: Text(
                        "Register",
                        style: style.copyWith(color: Colors.white,fontWeight: FontWeight.bold),
                      ),
                    onPressed: () {
                      // if (_registerFormKey.currentState!.validate()) {
                      //   if (pwdInputController!.text ==
                      //       confirmPwdInputController!.text) {
                      //     FirebaseAuth.instance
                      //         .createUserWithEmailAndPassword(
                      //             email: emailInputController!.text,
                      //             password: pwdInputController!.text)
                      //         .then((currentUser) => FirebaseFirestore.instance
                      //             .collection("users")
                      //             .doc(users.toString())
                      //             .set({
                      //               "id": users.toString(),
                      //               "fname": firstNameInputController!.text,
                      //               "surname": lastNameInputController!.text,
                      //               "email": emailInputController!.text,
                      //             })
                      //             .then((result) => {
                      //                   Navigator.pushAndRemoveUntil(
                      //                       context,
                      //                       MaterialPageRoute(
                      //                           builder: (context) => MyHomePage(
                      //                                 title:
                      //                                     "Welcome"+firstNameInputController
                      //                                             !.text,
                                                              
                      //                                 id: users.toString(),
                      //                               )),
                      //                       (_) => false),
                      //                   firstNameInputController!.clear(),
                      //                   lastNameInputController!.clear(),
                      //                   emailInputController!.clear(),
                      //                   pwdInputController!.clear(),
                      //                   confirmPwdInputController!.clear()
                      //                 })
                      //             .catchError((err) => print(err)))
                      //         .catchError((err) => print(err));
                      //   } else {
                      //     showDialog(
                      //         context: context,
                      //         builder: (BuildContext context) {
                      //           return AlertDialog(
                      //             title: Text("Error"),
                      //             content: Text("The passwords do not match"),
                      //             actions: <Widget>[
                      //               ElevatedButton(
                      //                 child: Text("Close"),
                      //                 onPressed: () {
                      //                   Navigator.of(context).pop();
                      //                 },
                      //               )
                      //             ],
                      //           );
                      //         });
                      //   }
                      // }
                    },
                  ),
                  Padding(padding:EdgeInsets.fromLTRB(20, 15, 10, 15)),
                  Text("Already have an account?",),
                  ElevatedButton(
                    child: Text("Login here!"),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            ))));
  }
}