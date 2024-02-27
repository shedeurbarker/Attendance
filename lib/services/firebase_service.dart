// firebase_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

import '../models/lecture_model.dart';
import '../models/student_model.dart';

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final logger = Logger();

  Future<void> registerStudent(Student student) async {
    try {
      await _firestore.collection('students').doc(student.id).set(student.toMap());
    } catch (e, stackTrace) {
      logger.e('Error: $e, $stackTrace');
    }
  }

  Future<void> createLecture(Lecture lecture) async {
    try {
      await _firestore.collection('lectures').doc(lecture.id).set(lecture.toMap());
      logger.e('status: ${lecture.id}');
    } catch (e, stackTrace) {
      logger.e('Error: $e, $stackTrace');
    }
  }

  Future<Student?> getStudentById(String studentId) async {
    try {
      DocumentSnapshot studentSnapshot = await _firestore.collection('students')
          .doc(studentId)
          .get();
      if (studentSnapshot.exists) {
        Map<String, dynamic>? studentData = studentSnapshot.data() as Map<
            String,
            dynamic>?;
        if (studentData != null) {
          // Check for null before accessing fields
          return Student(
            id: studentSnapshot.id,
            name: studentData['name'] ?? '',
            // Provide default value if null
            thumbprint: studentData['thumbprint'] ?? '',
            // Provide default value if null
            level: studentData['level'] ?? '', // Provide default value if null
          );
        }
      }
      return null; // Student with the provided ID does not exist or has no data
    }
    catch (e, stackTrace) {
      logger.e('Error: $e, $stackTrace');
    }
    return null;
  }
}
