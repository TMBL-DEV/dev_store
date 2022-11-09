import 'package:dev_store/screens/supplier/overview_screen.dart';
import 'package:dev_store/screens/supplier/profile_screen.dart';
import 'package:dev_store/widgets/appbar.dart';
import 'package:dev_store/widgets/default_page_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SupplierMainPage extends StatefulWidget {
  const SupplierMainPage({super.key});

  @override
  State<SupplierMainPage> createState() => _SupplierMainPageState();
}

class _SupplierMainPageState extends State<SupplierMainPage> {
  int _selectedIndex = 0;
  final List<Widget?> tabs = [const OverviewScreen(), const ProfileScreen()];

  late User authUser;
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    authStateCheck();
  }

  void authStateCheck() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        if (user != null) {
          authUser = user;
        }

        loggedIn = user != null;

        if (!loggedIn) {
          Navigator.pushNamed(context, '/auth');
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: personalBar(title: 'DevStore 🔥'),
      body: defaultPageContainer(child: tabs[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
