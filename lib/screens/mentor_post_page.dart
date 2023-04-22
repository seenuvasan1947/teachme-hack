// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../components/constant.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/language/lang_strings.dart';
import '../components/provider.dart';

class postaddscreen extends StatefulWidget {
  const postaddscreen({super.key});

  @override
  State<postaddscreen> createState() => _postaddscreenState();
}

class _postaddscreenState extends State<postaddscreen> {
  late String mentor_name;
  late String mentor_email;
  late String mentor_domain;

  final db = FirebaseFirestore.instance;
  Future<String?> adddata() async {
    FirebaseFirestore.instance.collection("posts").doc(mentor_email).set({
      'poster_name': Getcurrentuser.crnt_user,
      'mentor_name': mentor_name,
      'mentor_email': mentor_email,
      'mentor_domain': mentor_domain,
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: AlertDialog(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close))
          ],
          title:  Text(AppLocale.Mentor_post.getString(context)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                  enableIMEPersonalizedLearning: true,
                  autocorrect: true,
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    mentor_name = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: AppLocale.Enter_Your_Name.getString(context))),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    mentor_email = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText:AppLocale.Enter_Your_Email.getString(context))),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                  obscureText: false,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    mentor_domain = value;
                    //Do something with the user input.
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: AppLocale.Enter_Your_Domain.getString(context))),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    adddata();
                  },
                  child: Text(AppLocale.Save.getString(context))),
            ],
          ),
        ),
      ),
    );
  }
}
