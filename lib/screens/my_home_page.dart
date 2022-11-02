import 'package:dev_store/services/experience_service.dart';
import 'package:dev_store/widgets/appbar.dart';
import 'package:dev_store/widgets/auth/login_form.dart';
import 'package:dev_store/widgets/default_page_container.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: personalBar(),
      body: defaultPageContainer(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            const Text(
              'Choose Experience',
              style: TextStyle(fontSize: 30),
            ),
            const Padding(
              padding: EdgeInsets.all(40),
            ),
            ElevatedButton(
              onPressed: () {
                ExperienceService.instance.setExperience('/customer');
                Navigator.pushReplacementNamed(context, '/customer');
              },
              child: const Text(
                'Customer Experience',
                style: TextStyle(fontSize: 20),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(20),
            ),
            ElevatedButton(
              onPressed: () {
                ExperienceService.instance.setExperience('/supplier');
                Navigator.pushReplacementNamed(context, '/supplier');
              },
              child: const Text(
                'Supplier Experience',
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }
}
