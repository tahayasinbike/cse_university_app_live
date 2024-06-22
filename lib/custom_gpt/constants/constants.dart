//String THREAD_ID = "thread_HNuAvl8ej6bx8M84peC7w7ye";
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main(level) async {
  Privacy privacy = Privacy();
  String API_KEY = await privacy.getApiKey();
  String BASE_URL = await privacy.getBaseUrl();
  String ASSISTANT_ID = await privacy.getAssistantId(level: level);

  print(API_KEY);
  print(BASE_URL);
  print(ASSISTANT_ID);
}

class Privacy {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String> getApiKey() async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firebaseFirestore.collection("privacy").doc("apikey").get();
    return doc.data()?["apikey1"] ?? "";
  }

  Future<String> getBaseUrl() async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firebaseFirestore.collection("privacy").doc("baseurl").get();
    return doc.data()?["baseurl"] ??
        ""; // Assuming "url" is the field name for base URL
  }

  Future<String> getAssistantId({required String level}) async {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await _firebaseFirestore.collection("privacy").doc(level).get();
    return doc.data()?["asistan"] ??
        ""; // Assuming "id" is the field name for assistant ID
  }
}
