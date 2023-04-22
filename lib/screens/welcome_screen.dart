// ignore_for_file: duplicate_import

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../components/language/lang_strings.dart';
import '../components/forms/login_screen.dart';
import '../components/forms/mentor_register_form.dart';
import '../components/forms/student_registor_form.dart';
import '../components/language/lang_select.dart';
import '../components/language/lang_strings.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(AppLocale.welcome.getString(context)),centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => LangSelect()));
                },
                icon: Icon(Icons.language_outlined)),
          ],
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.45,
                child: Image.asset('assets/teach3.jpeg'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Mentor_Reg()));
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
                child: Text(AppLocale.Register_as_mentor.getString(context)),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Student_Reg()));
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
                child: Text(AppLocale.Register_as_student.getString(context)),
              ),
              Divider(thickness: 6),
              Text(AppLocale.Already_a_user_login.getString(context)),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Loginpage()));
                },
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)))),
                child: Text(AppLocale.Login.getString(context)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
