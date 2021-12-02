import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/db/student_model.dart';
import 'package:sqflite/sqflite.dart';

ValueNotifier<List<StudentModel>> studentList = ValueNotifier([]);

late Database _db;
Future<void> myDatabase() async {
  _db = await openDatabase('student.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, age TEXT)');
  });
}

Future<void> addStudents(StudentModel value) async {
  await _db.rawInsert(
      'INSERT INTO student (name,age) VALUES(?,?)', [value.name, value.age]);
  getAllStudents();
}

Future<void> getAllStudents() async {
  studentList.value.clear();
  final _values = await _db.rawQuery('SELECT * FROM student');

  for (var map in _values) {
    final student = StudentModel.fromMap(map);
    studentList.value.add(student);
    studentList.notifyListeners();
  }
}

Future<void> deleteStudent(int? id) async {
  await _db.rawDelete('DELETE FROM student WHERE id = ? ', [id]);
  getAllStudents();
}

Future updateData(BuildContext context, id) async {
  studentList.notifyListeners();
  return showDialog(
      context: context,
      builder: (context) {
        final _title = TextEditingController();
        final _subject = TextEditingController();
        return AlertDialog(
          backgroundColor: Colors.white,
          actionsPadding: const EdgeInsets.all(16),
          actions: [
            TextField(
              controller: _title,
              decoration: const InputDecoration(
                  hintText: 'name', hintStyle: TextStyle(color: Colors.grey)),
              style: const TextStyle(color: Colors.black),
            ),
            TextField(
                controller: _subject,
                decoration: const InputDecoration(
                    hintText: 'age',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    )),
                style: const TextStyle(color: Colors.black)),
            TextButton(
                onPressed: () async {
                  if (_title.text.isEmpty || _subject.text.isEmpty) {
                    return;
                  }
                  final name = _title.text;
                  final age = _subject.text;

                  await _db.rawUpdate(
                      'UPDATE student SET name = ?, age = ? WHERE id = ?',
                      [name, age, id]);

                  Navigator.pop(context);

                  getAllStudents();
                },
                child: const Text(
                  'Update',
                  style: TextStyle(fontSize: 16),
                ))
          ],
        );
      });
}
