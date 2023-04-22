// ignore_for_file: use_build_context_synchronously, avoid_init_to_null, non_constant_identifier_names, body_might_complete_normally_nullable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '/components/constant.dart';
import '/components/language/lang_select.dart';
import '/components/language/lang_strings.dart';
import '/screens/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  late String user_email;
  late String user_password;
  final _auth = FirebaseAuth.instance;
  late var newuser = null;

  Future<String?> user_login() async {
    try {
      newuser = await _auth.signInWithEmailAndPassword(
          email: user_email, password: user_password);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_email', user_email);

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
        title: Text(AppLocale.Login.getString(context)),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LangSelect()));
              },
              icon: const Icon(Icons.language_outlined)),
        ],
      ),
      body: Center(
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
                  user_email = value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: AppLocale.Enter_Your_Email.getString(context))),
            const SizedBox(
              height: 30.0,
            ),
            TextField(
                enableIMEPersonalizedLearning: true,
                autocorrect: true,
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  user_password = value;
                  //Do something with the user input.
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText:
                        AppLocale.Enter_your_Password.getString(context))),
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
                    user_login();
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
    );
  }
}
