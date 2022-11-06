import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection("products").snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            String placeHolder = "https://placekitten.com/200/300";

            Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;

            List pictures = data['imagePaths'];
            final storageRef =
                FirebaseStorage.instance.ref().child(pictures[0]);
            // .child(pictures[0]);

            // storageRef.getDownloadURL().then((value) {
            //   var pauze = true;
            // });

            return ListTile(
              title: Text(data['name']),
              subtitle: Text(data['description']),
              leading: Image.network(placeHolder),
            );
          }).toList(),
        );
      },
    );
  }
}
