//String THREAD_ID = "thread_HNuAvl8ej6bx8M84peC7w7ye";
import 'package:cloud_firestore/cloud_firestore.dart';

String API_KEY = "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";
String BASE_URL = "https://api.openai.com/v1";
String ASSISTANT_ID = "asst_4nnUpQldjhTdsS9wmo7OGOc4";

class Privacy {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> getApiKey() async {
    CollectionReference apiRef = _firebaseFirestore.collection("privacy");
    var apiDoc = apiRef.doc("apikey"); //{name: taha, surname:bike}
    var response = await apiDoc.get() as DocumentSnapshot<Map<String, dynamic>>;
    //print(response.data());
    return response.data();
  }

  Future<Map<String, dynamic>?> getBaseUrl() async {
    CollectionReference baseUrlRef = _firebaseFirestore.collection("privacy");
    var baseUrlDoc = baseUrlRef.doc("baseurl"); //{name: taha, surname:bike}
    var response =
        await baseUrlDoc.get() as DocumentSnapshot<Map<String, dynamic>>;
    //print(response.data());
    return response.data();
  }
}
