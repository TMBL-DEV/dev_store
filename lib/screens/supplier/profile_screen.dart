import 'package:dev_store/services/experience_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late User authUser;
  bool loggedIn = false;

  void authStateCheck() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        if (user != null) {
          authUser = user;
        }

        loggedIn = user != null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    authStateCheck();
    if (loggedIn) {
      return Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Email: "),
              Text(authUser.email ?? "no email"),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("verified email: "),
              Text(authUser.emailVerified ? "Verified" : "Not Verified"),
            ],
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    ExperienceService.instance.setExperience('/customer');
                    Navigator.pushReplacementNamed(context, '/customer');
                  },
                  child: const Text(
                    'Switch to Customer Experience',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("not logged in"),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                  onPressed: () {
                    // ExperienceService.instance.setExperience('/supplier');
                    Navigator.pushNamed(context, '/auth');
                  },
                  child: const Text(
                    'Register / login',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    ExperienceService.instance.setExperience('/supplier');
                    Navigator.pushReplacementNamed(context, '/supplier');
                  },
                  child: const Text(
                    'Switch to Supplier Experience',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          )
        ],
      );
    }
  }
}
