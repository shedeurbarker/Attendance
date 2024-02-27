// attendance_service.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class AttendanceService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> recordAttendance(String lectureId, String studentId) async {
    try {
      await _firestore.collection('attendance').doc().set({
        'lectureId': lectureId,
        'studentId': studentId,
        'timestamp': Timestamp.now(),
      });
    } catch (e) {
      //print('Error recording attendance: $e');
    }
  }
}
