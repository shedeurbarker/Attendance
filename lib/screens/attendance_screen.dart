import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../services/attendance_service.dart';
import '../services/firebase_service.dart';
import '../services/lecture_service.dart';


 class AttendanceScreen extends StatefulWidget {
   final Lectures lecture;
  const AttendanceScreen({super.key, required this.lecture});

  @override
  AttendanceScreenState createState() => AttendanceScreenState();
}

class AttendanceScreenState extends State<AttendanceScreen> {
  final FirebaseService _firebaseService = FirebaseService();
  final AttendanceService _attendanceService = AttendanceService();
  late Student _currentStudent;
  bool _isAttendanceRecorded = false;
  String _selectedLectureTitle = 'Attendance';

  void _updateAppBarTitle() {
    setState(() {
      _selectedLectureTitle = widget.lecture.title;
    });
  }

  @override
  void initState() {
    super.initState();
    _updateAppBarTitle();
    _loadCurrentStudent();
  }

  Future<void> _loadCurrentStudent() async {
    // Example implementation: Load student with thumbprint from Firebase
    String currentStudentId = 'current_student_id'; // Replace with actual student ID
    Student? student = await _firebaseService.getStudentById(currentStudentId);
    if (student != null) {
      setState(() {
        _currentStudent = student;
      });
    }
  }

  void _recordAttendance() {
    if (!_isAttendanceRecorded) {
      // Record attendance for the current student if not already recorded
      _attendanceService.recordAttendance(_currentStudent.id, widget.lecture.id);
      setState(() {
        _isAttendanceRecorded = true;
      });
      // Show a snack bar to indicate success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attendance recorded successfully')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_selectedLectureTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Lecture Title: ${widget.lecture.title}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Lecturer Name: ${widget.lecture.lecturer}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildAttendanceButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceButton() {
    if (_isAttendanceRecorded) {
      return const Text('Attendance Recorded');
    } else {
      return ElevatedButton(
        onPressed: _recordAttendance,
        child: const Text('Record Attendance'),
      );
    }
  }
}

