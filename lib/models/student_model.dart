// student_model.dart
class Student {
  String id;
  String name;
  String thumbprint;
  String level;


  Student({required this.id, required this.name, required this.thumbprint, required this.level});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'thumbprint': thumbprint,
      'level': level,
    };
  }
}