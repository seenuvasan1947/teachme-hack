import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/language/lang_select.dart';
import '../components/language/lang_strings.dart';
import '../components/provider.dart';

class mentorList extends StatefulWidget {
  const mentorList({super.key});

  @override
  State<mentorList> createState() => _mentorListState();
}

class _mentorListState extends State<mentorList> {
  final db = FirebaseFirestore.instance;

//  Getcurrentuser.userEmail;
String? crnt_usr=Getcurrentuser.crnt_email;
  Future<String?> add_to_fav(
      mentor_email, mentor_name, mentor_bio, mentor_domain) async {
    try {
      FirebaseFirestore.instance
          .collection("students")
          .doc(crnt_usr)
          .collection('fav_mentors')
          .doc(mentor_email)
          .set({
        'mentor_email': mentor_email,
        'mentor_name': mentor_name,
        'mentor_bio': mentor_bio,
        'mentor_domain': mentor_domain,
      });
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

  Future<void> send(senderemail) async {
    var recMail = senderemail;
    final Email email = Email(
      body: AppLocale.mentor_mail_body.getString(context),
      subject: AppLocale.mail_sub.getString(context),
      recipients: [recMail],
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
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocale.Post_list.getString(context)),
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
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: db.collection('mentors').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: snapshot.data!.docs.map((doc) {
                      return Card(
                        child: ListTile(
                          title: Text(doc['mentor_domain']),
                          subtitle: Text(doc['mentor_name']),
                          trailing: IconButton(
                              onPressed: () {
                                send(doc['mentor_email']);
                              },
                              icon: Icon(Icons.send)),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SingleChildScrollView(
                                    child: AlertDialog(
                                      actions: [
                                        IconButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            icon: const Icon(Icons.close))
                                      ],
                                      title: Text(
                                          AppLocale.Post_details.getString(
                                              context)),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            AppLocale.Mentor_name.getString(
                                                context),
                                            style: TextStyle(fontSize: 24),
                                          ),
                                          const SizedBox(
                                            height: 27,
                                          ),
                                          Text(doc['mentor_name']),
                                          const SizedBox(
                                            height: 35,
                                          ),
                                          Text(
                                            AppLocale.Mentor_domain.getString(
                                                context),
                                            style: TextStyle(fontSize: 24),
                                          ),
                                          const SizedBox(
                                            height: 27,
                                          ),
                                          Text(doc['mentor_domain']),
                                          const SizedBox(
                                            height: 35,
                                          ),
                                          Text(
                                            AppLocale.Mentor_email.getString(
                                                context),
                                            style: TextStyle(fontSize: 24),
                                          ),
                                          const SizedBox(
                                            height: 27,
                                          ),
                                          Text(doc['mentor_email']),
                                          const SizedBox(
                                            height: 35,
                                          ),
                                          Text(
                                            AppLocale.Mentor_bio.getString(
                                                context),
                                            style: TextStyle(fontSize: 24),
                                          ),
                                          const SizedBox(
                                            height: 27,
                                          ),
                                          Text(doc['mentor_bio']),
                                          const SizedBox(
                                            height: 35,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              add_to_fav(
                                                  doc['mentor_email'],
                                                  doc['mentor_name'],
                                                  doc['mentor_bio'],
                                                  doc['mentor_domain']);
                                            },
                                            style: ButtonStyle(
                                                shape: MaterialStateProperty.all<
                                                        RoundedRectangleBorder>(
                                                    RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    30)))),
                                            child: Text(AppLocale
                                                .add_as_fav_mentor
                                                .getString(context)),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
