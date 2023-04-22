// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_localization/flutter_localization.dart';
import '../components/language/lang_select.dart';
import '../components/language/lang_strings.dart';
import '../components/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class mypostlist extends StatefulWidget {
  const mypostlist({super.key});

  @override
  State<mypostlist> createState() => _mypostlistState();
}

class _mypostlistState extends State<mypostlist> {
  final db = FirebaseFirestore.instance;
  final prefs = SharedPreferences.getInstance();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(AppLocale.My_post_list.getString(context)),
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
              stream: db
                  .collection('posts')
                  .where("poster_name",
                      isEqualTo: '${Getcurrentuser.crnt_user}')
                  .snapshots(),
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
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection("posts")
                                    .doc(doc['mentor_email'])
                                    .delete();
                              },
                              icon: const Icon(Icons.remove)),
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
                                      title: Text(AppLocale.My_post_details.getString(context)),
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
