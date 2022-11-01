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
      body: defaultPageContainer(child: Text("todo fix products")),
    );
  }
}
