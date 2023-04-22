import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../components/language/lang_select.dart';
import '../components/language/lang_strings.dart';

class postlist extends StatefulWidget {
  const postlist({super.key});

  @override
  State<postlist> createState() => _postlistState();
}

class _postlistState extends State<postlist> {
  final db = FirebaseFirestore.instance;

  Future<void> send(senderemail) async {
    var rec_mail = senderemail;
    final Email email = Email(
      body: AppLocale.mentor_mail_body.getString(context),
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
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocale.Post_list.getString(context)),
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
              stream: db.collection('posts').snapshots(),
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
                                      title:  Text(AppLocale.Post_details.getString(context)),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                           Text(
                                           AppLocale.Mentor_name.getString(context),
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
                                            AppLocale.Mentor_domain.getString(context),
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
                                            AppLocale.Mentor_email.getString(context),
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
                                            AppLocale.Posted_by.getString(context),
                                            style: TextStyle(fontSize: 24),
                                          ),
                                          const SizedBox(
                                            height: 27,
                                          ),
                                          Text(doc['poster_name']),
                                          const SizedBox(
                                            height: 35,
                                          ),
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
