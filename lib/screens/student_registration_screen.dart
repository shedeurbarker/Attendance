import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class StudentRegistrationScreen extends StatefulWidget {
  const StudentRegistrationScreen({super.key});

  @override
  State<StudentRegistrationScreen> createState() => _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  final LocalAuthentication _localAuth = LocalAuthentication();

  Future<void> _authenticate() async {
    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Scan your fingerprint to register',
        useErrorDialogs: true,
        stickyAuth: true,
      );
      if (authenticated) {
        // Fingerprint authentication successful, proceed with registration
        // Implement your registration logic here
      }
    } catch (e) {
      print('Error during biometric authentication: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Student'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _authenticate,
          child: Text('Scan Thumbprint'),
        ),
      ),
    );
  }
}
