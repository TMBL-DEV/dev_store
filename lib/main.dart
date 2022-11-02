import 'package:dev_store/screens/auth/auth_page.dart';
import 'package:dev_store/screens/customer/main_page.dart';
import 'package:dev_store/screens/my_home_page.dart';
import 'package:dev_store/screens/supplier/main_page.dart';
import 'package:dev_store/services/experience_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'firebase_options.dart';

void main() async {
  String initalRoute = '/welcome';

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  await ExperienceService.instance.openBox();

  String experience = ExperienceService().retrieveExperience();
  if (experience != 'empty') {
    initalRoute = experience;
  }

  runApp(
    MaterialApp(
      initialRoute: initalRoute,
      routes: {
        '/welcome': (context) => const MyHomePage(),
        '/customer': (context) => const CustomerMainPage(),
        '/supplier': (context) => const SupplierMainPage(),
        '/auth': (context) => const AuthPage(),
      },
    ),
  );
}
