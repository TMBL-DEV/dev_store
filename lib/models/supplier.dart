import 'package:cloud_firestore/cloud_firestore.dart';

class Supplier {
  String _id;
  String name;
  String userId;

  Supplier(
    this._id, {
    required this.name,
    required this.userId,
  });

  String getId() {
    return _id;
  }

  factory Supplier.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    return Supplier(snapshot.id,
        name: snapshot.get('name'), userId: snapshot.get('userId'));
  }
}
