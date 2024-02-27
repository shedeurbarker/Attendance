import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../models/lecture_model.dart';
import '../network_utils.dart';
import '../services/firebase_service.dart';

class LectureCreationScreen extends StatefulWidget {

  const LectureCreationScreen({super.key});

  @override
  State<LectureCreationScreen> createState() => _LectureCreationScreenState();
}

class _LectureCreationScreenState extends State<LectureCreationScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _courseCodeController = TextEditingController();
  final TextEditingController _lectureNameController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  final logger =Logger();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Lecture'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Lecture Title',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _courseCodeController,
              decoration: const InputDecoration(
                labelText: 'Course Code',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _lectureNameController,
              decoration: const InputDecoration(
                labelText: 'Lecture Name',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                bool isConnected = await NetworkUtils.checkConnectivity();
                if (isConnected) {
                  // Handle network connectivity
                  logger.e('Device is connected to the internet.');
                  _createLecture();
                } else {
                  // Handle no network connectivity
                  logger.e('No internet connection.');
                }
              },
              child: const Text('Create Lecture'),
            ),
          ],
        ),
      ),
    );
  }

  void _createLecture() {
    String courseCode = _courseCodeController.text.trim();
    String lectureName = _lectureNameController.text.trim();
    String lectureTitle = _titleController.text.trim();

    if (courseCode.isNotEmpty && lectureName.isNotEmpty && lectureTitle.isNotEmpty) {
      // Generate a unique ID for the lecture
      String lectureId = DateTime.now().millisecondsSinceEpoch.toString();

      // Create a new Lecture object
      Lecture lecture = Lecture(id: lectureId, courseCode: courseCode, lecturer: lectureName, title: lectureTitle);

// Call the Firebase service to create the lecture
      _firebaseService.createLecture(lecture);

      // Show a snack bar to indicate success
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lecture created successfully')),
      );
      // Clear the text fields
     _courseCodeController.clear();
     _lectureNameController.clear();
     _titleController.clear();
     Navigator.pop(context);
    } else {
      // Show an error message if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a course code, lecture name, and lecture title')),
      );
    }
  }

}
