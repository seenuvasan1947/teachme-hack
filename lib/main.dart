// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, curly_braces_in_flow_control_structures, unused_import, depend_on_referenced_packages

import 'dart:io';

import 'package:flutter/material.dart';

import '../components/language/multi_lang.dart';
import '../components/provider.dart';
import '../screens/home_screen.dart';
import '../screens/welcome_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'components/language/multi_lang.dart';
import 'components/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Getcurrentuser()),
      ChangeNotifierProvider(create: (_) => LangPropHandler())
    ],
    child: MaterialApp(home: LangMainPage()),
  ));
}
