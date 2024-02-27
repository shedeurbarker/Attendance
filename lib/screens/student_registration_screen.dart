import 'package:attendees/screens/lecture_creation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

class StudentRegistrationScreen extends StatefulWidget {
  const StudentRegistrationScreen({super.key});

  @override
  State<StudentRegistrationScreen> createState() => _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {

  LocalAuthentication auth = LocalAuthentication();

  bool _canCheckBiometric =false;

  late List<BiometricType> _availableBiometrics;
  String autherized = "Not autherized";

  Future<void> _checkBiometric() async {
    bool canCheckBiometric = false;
    try {
      canCheckBiometric = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) return;
    setState(() {
      _canCheckBiometric = canCheckBiometric;
    });
  }

  Future<void> _getAvailableBiometric() async {
    late List<BiometricType> availableBiometric;

    try{

      availableBiometric = await auth.getAvailableBiometrics();
    } on PlatformException catch (e){
      print(e);
    }
    setState(() {
      _availableBiometrics = availableBiometric;
    });
  }

  Future<void> _authenticate() async{
    bool authenticated = false;
    try{
      authenticated = await auth.authenticate(
          localizedReason: "Scan your finger to authenticate",
      );
    } on PlatformException catch(e){
      print(e);
    }

    if (!mounted) return;

    setState(() {
      autherized = authenticated ? "Autherized success":"Failed to authenticate";
      if(authenticated){
        Navigator.push(context,MaterialPageRoute(builder: (context) => const LectureCreationScreen()));
      }

      print(autherized);
    });
  }

  @override

  void initState(){
    super.initState();
    _checkBiometric();
    _getAvailableBiometric();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Center(
                child: Text("Login",style: TextStyle(
                    color: Colors.white,
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold

                ),),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 50.0),
                  child: Column(
                      children: <Widget>[

                        const Text("Fingerprint Auth", style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),),
                        Container(
                          width: 150.0,
                          margin: const EdgeInsets.symmetric(vertical: 15.0),
                          child: const Text("Authenticate with your fingerprint instead of your password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              height: 1.5,
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.symmetric(vertical: 15.0 ),
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: _authenticate,
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical:14.0,horizontal: 24.0),
                                  child: Text("Authenticate", style: TextStyle(
                                    color: Colors.white,
                                  ),),
                                )
                            )
                        )
                      ]
                  )
              )
            ],
          ),
        ) ,
      ),
    );
  }
}
