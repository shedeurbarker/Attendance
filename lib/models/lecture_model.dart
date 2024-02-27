class Lecture {
  String id;
  String title;
  String courseCode;
  String lecturer;

  Lecture({required this.id, required this.title, required this.courseCode, required this.lecturer});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'courseCode': courseCode,
      'lecturer': lecturer,
    };
  }
}