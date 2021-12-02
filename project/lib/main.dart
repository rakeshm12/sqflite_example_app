import 'package:flutter/material.dart';
import 'package:project/input.dart';
import 'package:project/student_list.dart';
import 'package:project/student_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await myDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage());
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getAllStudents();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sqlite Example'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (context) {
                  return const Center(child: InputData());
                });
          },
          child: const Icon(Icons.add_comment),
        ),
        body: StudentWidget());
  }
}
