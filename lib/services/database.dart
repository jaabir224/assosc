import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addMember(Map<String, dynamic> memberMap, String id) async {
    return FirebaseFirestore.instance
        .collection("Membre")
        .doc(id)
        .set(memberMap);
  }

  Future<Stream<QuerySnapshot>> getMembers() async {
    return FirebaseFirestore.instance.collection("Membre").snapshots();
  }
}
