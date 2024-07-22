import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_university_app/pages/clubs/model/club_model.dart';

class ClubService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<Club>> getClubs() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('clubs').get();
      return snapshot.docs.map((doc) {
        return Club.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load clubs');
    }
  }
}
