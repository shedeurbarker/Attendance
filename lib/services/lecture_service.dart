// lecture_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class LectureService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<Lectures>> getLectures() {
    return _firestore.collection('lectures').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Lectures.fromMap(doc.data())).toList());
  }
}

class Lectures {
  String id;
  String title;
  String courseCode;
  String lecturer;

  Lectures({required this.id, required this.title, required this.courseCode, required this.lecturer});

  factory Lectures.fromMap(Map<String, dynamic> map) {
    return Lectures(
      id: map['id'],
      title: map['title'],
      courseCode: map['courseCode'],
      lecturer: map['lecturer'],
    );
  }
}
