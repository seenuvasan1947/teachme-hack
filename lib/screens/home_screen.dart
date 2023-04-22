// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_function_type_syntax_for_parameters, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../components/language/lang_select.dart';
import '../components/language/lang_strings.dart';
import '../components/provider.dart';

import '../components/forms/login_screen.dart';
import '../components/provider.dart';

import 'package:provider/provider.dart';
import '../screens/mentor_post_page.dart';
import '../screens/post_list.dart';
import '../screens/my_post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    context.read<Getcurrentuser>().getuser();
  }

  Future<void> send(senderemail) async {
    var rec_mail = senderemail;
    final Email email = Email(
      body: AppLocale.devp_mail_body.getString(context),
      subject: AppLocale.mail_sub.getString(context),
      recipients: [rec_mail],
      isHTML: false,
    );

    String platformResponse;

    try {
      await FlutterEmailSender.send(email);
      platformResponse = AppLocale.Success.getString(context);
    } catch (error) {
      print(error);
      platformResponse = error.toString();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(platformResponse),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Getcurrentuser>(
        builder: ((context, Getcurrentuser, child) => MaterialApp(
              home: Scaffold(
                appBar: AppBar(
                  title: Text(AppLocale.welcome.getString(context)),
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
                drawer: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      DrawerHeader(
                        // ignore: prefer_const_constructors
                        decoration: BoxDecoration(
                          color: Colors.blue,
                        ),
                        //child: Text('Drawer Header'),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(AppLocale.welcome.getString(context)),
                            SizedBox(
                              height: 20,
                            ),
                            Text('${Getcurrentuser.userName}'),
                            SizedBox(
                              height: 20,
                            ),
                            Text('${Getcurrentuser.userEmail}'),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title:  Text(AppLocale.Mentor_post.getString(context)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const postaddscreen()));
                        },
                      ),
                      ListTile(
                        title:  Text(AppLocale.My_post.getString(context)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const mypostlist()));
                        },
                      ),
                      ListTile(
                        title:  Text(AppLocale.All_post.getString(context)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const postlist()));
                        },
                      ),
                      ListTile(
                        title:  Text(AppLocale.Logout.getString(context)),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Loginpage()));
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListTile(
                        title:  Text(AppLocale.Chat_with_developer.getString(context)),
                        onTap: () {
                          send('seenuthiruvpm@gmail.com');
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                body: Center(
                  child: Column(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(top: 150),
                        margin: EdgeInsets.all(20),
                        height: MediaQuery.of(context).size.height / 1.2,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 250, 252, 250),
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              SizedBox(height: 110.0),
                              Text(AppLocale.welcome.getString(context),
                                  style: Theme.of(context)
                                      .textTheme
                                      .displayMedium),
                              SizedBox(height: 40.0),
                              Text(AppLocale.Unleash_your_skill.getString(context),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium),
                              SizedBox(height: 40.0),
                              Image.asset("assets/teach2.jpeg"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }
}
