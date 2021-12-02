

class StudentModel {
  int? id;

  final String name;

  final String age;

  StudentModel({required this.name, required this.age, this.id});

  static StudentModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int;
    final name = map['name'];
    final age = map['age'];
    return StudentModel(id: id, name: name.toString(), age: age.toString());
  }
}
