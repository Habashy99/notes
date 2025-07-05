import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes/controllers/hive.dart';
import 'package:notes/pages/home.dart';
import 'package:notes/pages/login.dart';
import 'package:notes/pages/note_details.dart';
import 'package:notes/pages/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await HiveService.initHiveBoxes(); // ✅ clean open logic

  runApp(MyApp());
}

class MyApp extends HookWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Note',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Login(),
    );
  }
}
