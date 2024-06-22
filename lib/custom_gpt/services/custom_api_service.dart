import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class CustomService {
  static Future<String> getMessagesValue(
      {required String thread,
      required String base_url,
      required String api_key}) async {
    try {
      var response = await http.get(
        Uri.parse("$base_url/threads/$thread/messages"),
        headers: {
          "Authorization": "Bearer $api_key",
          "Content-Type": "application/json",
          "OpenAI-Beta": "assistants=v1"
        },
      );

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('error')) {
        throw Exception(jsonResponse['error']['message']);
      }

      if (jsonResponse['data'] != null && jsonResponse['data'].isNotEmpty) {
        List<dynamic> dataSet = await jsonResponse["data"];
        Map<String, dynamic> firstList = await dataSet[0];
        List<dynamic> content = await firstList["content"];
        Map<String, dynamic> firstContent = await content[0];
        Map<String, dynamic> text = await firstContent["text"];
        String value = await utf8.decode(text["value"].toString().codeUnits);

        //print("$value");
        print("getMessages");
        return value;
      } else {
        return "No messages found.";
      }
    } catch (e) {
      print(e);
      return "Lütfen tekrar deneyiniz sizi anlayamadım";
    }
  }

  //send Message fct
  static Future<void> createMessage(
      {required String message,
      required String thread,
      required String api_key,
      required String base_url}) async {
    try {
      var response =
          await http.post(Uri.parse("$base_url/threads/$thread/messages"),
              headers: {
                "Authorization": "Bearer $api_key",
                "Content-Type": "application/json",
                "OpenAI-Beta": "assistants=v1"
              },
              body: jsonEncode({"role": "user", "content": message}));

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse["error"] != null) {
        print("jsonResponse['error'] ${jsonResponse["error"]["message"]}");
        throw HttpException(jsonResponse["error"]["message"]);
      }

      print("createMessages");
    } catch (error) {
      print("error $error");
      rethrow;
    }
  }

  // create run
  static Future<String> createRun(
      {required String thread,
      required String api_key,
      required String assistant_id}) async {
    try {
      var response = await http.post(
          Uri.parse("https://api.openai.com/v1/threads/$thread/runs"),
          headers: {
            "Authorization": "Bearer $api_key",
            "Content-Type": "application/json",
            "OpenAI-Beta": "assistants=v1"
          },
          body: jsonEncode({"assistant_id": "$assistant_id"}));

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse["error"] != null) {
        print("jsonResponse['error'] ${jsonResponse["error"]["message"]}");
        throw HttpException(jsonResponse["error"]["message"]);
      }
      String runId = jsonResponse["id"];
      print(runId);
      return runId;
    } catch (error) {
      print("error $error");
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getThread() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    CollectionReference threadRef = firebaseFirestore.collection("thread");
    var userDoc = threadRef.doc("thread1"); //{name: taha, surname:bike}
    var response =
        await userDoc.get() as DocumentSnapshot<Map<String, dynamic>>;
    return response.data();
  }

  // Create Thread
  static Future<String> createThread({required String api_key}) async {
    try {
      var response = await http.post(
        Uri.parse("https://api.openai.com/v1/threads"),
        headers: {
          "Authorization": "Bearer $api_key",
          "Content-Type": "application/json",
          "OpenAI-Beta": "assistants=v1"
        },
      );

      Map jsonResponse = jsonDecode(response.body);

      if (jsonResponse["error"] != null) {
        print("jsonResponse['error'] ${jsonResponse["error"]["message"]}");
        throw HttpException(jsonResponse["error"]["message"]);
      }

      String getThreadId = jsonResponse["id"];
      return getThreadId;
    } catch (error) {
      print("error $error");
      rethrow;
    }
  }

  static Future<String> runSteps(
      {required String thread,
      required String runId,
      required String base_url,
      required String api_key}) async {
    try {
      var response = await http.get(
        Uri.parse("$base_url/threads/$thread/runs/$runId/steps"),
        headers: {
          "Authorization": "Bearer $api_key",
          "Content-Type": "application/json",
          "OpenAI-Beta": "assistants=v1"
        },
      );

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('error')) {
        throw Exception(jsonResponse['error']['message']);
      }
      List<dynamic> dataSet = await jsonResponse["data"];
      Map<String, dynamic> firstList = await dataSet[0];
      String getStatus = await firstList["status"];

      print(getStatus);
      return getStatus;
    } catch (e) {
      print(e);
      return "Lütfen tekrar deneyiniz sizi anlayamadım";
    }
  }
}
