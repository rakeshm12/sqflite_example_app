import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:project/student_list.dart';

import 'db/student_model.dart';

class StudentWidget extends StatelessWidget {
  StudentWidget({Key? key}) : super(key: key);

  final name = TextEditingController();
  final age = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: studentList,
        builder: (BuildContext context, List<StudentModel> studentList,
            Widget? child) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final data = studentList[index];

                return Slidable(
                  endActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    children: [
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          deleteStudent(data.id);
                        },
                        color: Colors.red,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          updateData(context, data.id);
                        },
                        color: Colors.black,
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(
                      'Name : ' + data.name,
                    ),
                    subtitle: Text(
                      'Age     : ' + data.age,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: studentList.length);
        });
  }
}
