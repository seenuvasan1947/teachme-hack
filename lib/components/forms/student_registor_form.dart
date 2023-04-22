// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '/components/constant.dart';
import '/components/language/lang_select.dart';
import '/components/language/lang_strings.dart';
import '/screens/home_screen.dart';
// import 'package:mentorme/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Student_Reg extends StatefulWidget {
  const Student_Reg({super.key});

  @override
  State<Student_Reg> createState() => _Student_RegState();
}

class _Student_RegState extends State<Student_Reg> {
  late String student_name;
  late String student_email;
  late String student_password;
  late String student_phone;

  final _auth = FirebaseAuth.instance;
  late var newuser = null;
  // late var newuser = 1;
  Future<String?> stud_reg() async {
    try {
      newuser = await _auth.createUserWithEmailAndPassword(
          email: student_email, password: student_password);
      FirebaseFirestore.instance.collection("students").doc(student_email).set({
        'student_email': student_email,
        'student_password': student_password,
        'student_name': student_name,
        'student_phone': student_phone,
      });
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', student_email);
      await prefs.setString('user_name', student_name);

      if (newuser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      }
    } catch (e) {
      AlertDialog(
        content: Center(
          child: Column(
            children: [Text(e.toString())],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.Please_fill_out_this_form.getString(context)),
        centerTitle: true,
        actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LangSelect()));
                },
                icon: Icon(Icons.language_outlined)),
          ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              TextField(
                  enableIMEPersonalizedLearning: true,
                  autocorrect: true,
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    student_name = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: AppLocale.Enter_Your_Name.getString(context))),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                  enableIMEPersonalizedLearning: true,
                  autocorrect: true,
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    student_email = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText:AppLocale.Enter_Your_Email.getString(context))),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                  enableIMEPersonalizedLearning: true,
                  autocorrect: true,
                  obscureText: true,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    student_password = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText:AppLocale.Enter_your_Password.getString(context))),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                  enableIMEPersonalizedLearning: true,
                  autocorrect: true,
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    student_phone = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText:AppLocale.Enter_Your_Phone_Number.getString(context))),
              const SizedBox(
                height: 30.0,
              ),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.36,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      stud_reg();
                    },
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)))),
                    child: Text(AppLocale.Submit.getString(context)),
                  ),
                ],
              ),
              const SizedBox(
                height: 60.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
