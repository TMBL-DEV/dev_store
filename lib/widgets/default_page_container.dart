import 'package:flutter/material.dart';

Container defaultPageContainer({Widget? child}) {
  // ignore: avoid_unnecessary_containers
  return Container(
    child: Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
        child: Container(child: child), //Container
      ),
    ),
  );
}
