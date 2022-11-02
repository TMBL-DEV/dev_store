import 'package:dev_store/widgets/appbar.dart';
import 'package:dev_store/widgets/auth/login_form.dart';
import 'package:dev_store/widgets/auth/register_form.dart';
import 'package:dev_store/widgets/default_page_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final List<Widget> screens = [const LoginForm(), const RegisterForm()];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: personalBar(title: 'DevStore Sign up🔥'),
      body: defaultPageContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            screens[_currentIndex],
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.login),
            label: 'Login',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.app_registration),
            label: 'register',
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
