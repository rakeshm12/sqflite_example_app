import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project/student_list.dart';
import 'package:project/db/student_model.dart';

class InputData extends StatefulWidget {
  const InputData({
    Key? key,
  }) : super(key: key);

  @override
  State<InputData> createState() => _InputDataState();
}

class _InputDataState extends State<InputData> {
  final name = TextEditingController();
  final age = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: SingleChildScrollView(
        child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            actions: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: name,
                    autofocus: true,
                    decoration: InputDecoration(
                      hintText: 'Enter Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: age,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    child: const Text('Add Student'),
                    onPressed: () {
                      onAddStudentClicked();
                    },
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(10.0),
                      padding:
                          MaterialStateProperty.all(const EdgeInsets.all(10.0)),
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  onAddStudentClicked() async {
    final _name = name.text.trim();
    final _age = age.text.trim();

    if (_age.isEmpty || _name.isEmpty) {
      return;
    }

    final _student = StudentModel(id: studentList.value.length, name: _name, age: _age);

    addStudents(_student);
    Navigator.pop(context);
  }
}
