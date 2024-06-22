import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cse_university_app/custom_gpt/constants/constants.dart';
import 'package:http/http.dart' as http;

class CustomService {
  static Future<String> getMessagesValue({required String thread}) async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/threads/$thread/messages"),
        headers: {
          "Authorization": "Bearer $API_KEY",
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
        List<dynamic> content =
            await firstList["content"]; // toList() kaldırıldı.
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

  /* static Future<String> getMessagesFirstId({required String thread}) async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/threads/$thread/messages"),
        headers: {
          "Authorization": "Bearer $API_KEY",
          "Content-Type": "application/json",
          "OpenAI-Beta": "assistants=v1"
        },
      );

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('error')) {
        throw Exception(jsonResponse['error']['message']);
      }

      if (jsonResponse['data'] != null) {
        //print(jsonResponse["object"]);
        //print(jsonResponse["first_id"]);
        //print(jsonResponse["last_id"]);
        String first_id = jsonResponse["first_id"];
        List<dynamic> dataSet = jsonResponse["data"].toList();
        Map<String, dynamic> firstList = dataSet[0];
        String id = firstList["id"];
        List<dynamic> content = firstList["content"].toList(); // buraya kadar doğru
        Map<String, dynamic> firstContent = content[0];
        Map<String, dynamic> text = firstContent["text"];
        String value = text["value"];


        print(first_id);
        List<dynamic> data = jsonResponse['data'];
        List<MessageResponse> chatList = data.map<MessageResponse>((json) => MessageResponse.fromJson(json)).toList();
        //print(chatList);
        return first_id;
      } else {
        return "";
      }
    } catch (e) {
      print(e);
      return "$e";
    }
  } */
  /* static Future<String> getMessagesLastId({required String thread}) async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/threads/$thread/messages"),
        headers: {
          "Authorization": "Bearer $API_KEY",
          "Content-Type": "application/json",
          "OpenAI-Beta": "assistants=v1"
        },
      );

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('error')) {
        throw Exception(jsonResponse['error']['message']);
      }

      if (jsonResponse['data'] != null) {
        //print(jsonResponse["object"]);
        //print(jsonResponse["first_id"]);
        //print(jsonResponse["last_id"]);
        String last_id = jsonResponse["last_id"];
        List<dynamic> dataSet = jsonResponse["data"].toList();
        Map<String, dynamic> firstList = dataSet[0];
        String id = firstList["id"];
        List<dynamic> content = firstList["content"].toList(); // buraya kadar doğru
        Map<String, dynamic> firstContent = content[0];
        Map<String, dynamic> text = firstContent["text"];
        String value = text["value"];


        print(last_id);
        List<dynamic> data = jsonResponse['data'];
        List<MessageResponse> chatList = data.map<MessageResponse>((json) => MessageResponse.fromJson(json)).toList();
        //print(chatList);
        return last_id;
      } else {
        return "";
      }
    } catch (e) {
      print(e);
      return "$e";
    }
  } */
  /* static Future<String> getMessagesId({required String thread}) async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/threads/$thread/messages"),
        headers: {
          "Authorization": "Bearer $API_KEY",
          "Content-Type": "application/json",
          "OpenAI-Beta": "assistants=v1"
        },
      );

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('error')) {
        throw Exception(jsonResponse['error']['message']);
      }

      if (jsonResponse['data'] != null) {
        //print(jsonResponse["object"]);
        //print(jsonResponse["first_id"]);
        //print(jsonResponse["last_id"]);
        List<dynamic> dataSet = jsonResponse["data"].toList();
        Map<String, dynamic> firstList = dataSet[0];
        String id = firstList["id"];
        List<dynamic> content = firstList["content"].toList(); // buraya kadar doğru
        Map<String, dynamic> firstContent = content[0];
        Map<String, dynamic> text = firstContent["text"];
        String value = text["value"];


        print(id);
        List<dynamic> data = jsonResponse['data'];
        List<MessageResponse> chatList = data.map<MessageResponse>((json) => MessageResponse.fromJson(json)).toList();
        //print(chatList);
        return id;
      } else {
        return "";
      }
    } catch (e) {
      print(e);
      return "$e";
    }
  } */
  //send Message fct
  static Future<void> createMessage(
      {required String message, required String thread}) async {
    try {
      var response =
          await http.post(Uri.parse("$BASE_URL/threads/$thread/messages"),
              headers: {
                "Authorization": "Bearer $API_KEY",
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
  static Future<String> createRun({required String thread}) async {
    try {
      var response = await http.post(
          Uri.parse("https://api.openai.com/v1/threads/$thread/runs"),
          headers: {
            "Authorization": "Bearer $API_KEY",
            "Content-Type": "application/json",
            "OpenAI-Beta": "assistants=v1"
          },
          body: jsonEncode({"assistant_id": "$ASSISTANT_ID"}));

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
  static Future<String> createThread() async {
    try {
      var response = await http.post(
        Uri.parse("https://api.openai.com/v1/threads"),
        headers: {
          "Authorization": "Bearer $API_KEY",
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
      {required String thread, required String runId}) async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/threads/$thread/runs/$runId/steps"),
        headers: {
          "Authorization": "Bearer $API_KEY",
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
      String getStatus = await firstList["status"]; // toList() kaldırıldı.

      print(getStatus);
      return getStatus;
    } catch (e) {
      print(e);
      return "Lütfen tekrar deneyiniz sizi anlayamadım";
    }
  }
}
