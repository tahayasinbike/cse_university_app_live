import 'package:cloud_firestore/cloud_firestore.dart';

class RingService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List> getSH() async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firebaseFirestore.collection("ring").doc("ringClocks").get();
    List shList = await doc.data()?["sh"];
    return shList;
  }

  Future<List> getHS() async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firebaseFirestore.collection("ring").doc("ringClocks").get();
    List hsList = await doc.data()?["hs"];
    return hsList;
  }
}
