// lecture_list_screen.dart
import 'package:attendees/screens/lecture_creation_screen.dart';
import 'package:attendees/screens/student_registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import '../services/lecture_service.dart';
import 'attendance_screen.dart';

class LectureListScreen extends StatelessWidget {
  final LectureService lectureService = LectureService();

  LectureListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Lectures'),
      ),
        body: StreamBuilder<List<Lectures>>(
          stream: lectureService.getLectures(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Text("Add lectures to begin");
            }
            List<Lectures>? lecturesList = snapshot.data;
            return ListView.builder(
              itemCount: lecturesList!.length,

              itemBuilder: (context, index) {
                Lectures lecture = lecturesList[index]; // Get the individual Lectures object
                return ListTile(
                  title: Text(lecture.title), // Access the title of the individual Lectures object
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AttendanceScreen(
                          lecture: lecture, // Pass the individual Lectures object directly
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: 'Create Lecture',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LectureCreationScreen()),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.person_add),
            label: 'Register Student',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const StudentRegistrationScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
