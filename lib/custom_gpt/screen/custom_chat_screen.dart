import 'package:cse_university_app/custom_gpt/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:cse_university_app/custom_gpt/services/custom_api_service.dart';
import 'package:cse_university_app/custom_gpt/widgets/chat_widget.dart';
import 'package:cse_university_app/pages/ois_blackboard/widgets/beyaz_istun_title.dart';
import 'package:cse_university_app/utils/custom_colors.dart';

// önce creat thread id yi alcaz sonra create message yapıp threadı run yapıcaz buraya kadar okey
// sonra run stepsin statusuna bakıcaz eğer completed ise mesajı getir diycez

// ignore: must_be_immutable
class CustomChatScreen extends StatefulWidget {
  String? rol;
  String? apiKey;
  String? baseUrl;
  CustomChatScreen({
    Key? key,
    required this.rol,
    required this.apiKey,
    required this.baseUrl,
  }) : super(key: key);

  @override
  State<CustomChatScreen> createState() => _CustomChatScreenState();
}

class _CustomChatScreenState extends State<CustomChatScreen> {
  late String thread = "";
  late String asistanId = "";
  late String API_KEY = "";
  late String BASE_URL = "";
  late String ASSISTANT_ID = "";
  //late String apiThread = "";
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  String? message;
  bool isLoading = false;
  String? chatRol = "";
  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
    print("chat sayfasi rol => ${widget.rol}");
    chatRol = widget.rol;
    getInfo();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> getInfo() async {
    API_KEY = await Privacy().getApiKey();
    BASE_URL = await Privacy().getBaseUrl();
    ASSISTANT_ID = await Privacy().getAssistantId(level: chatRol ?? "");
    setState(() {
      API_KEY = API_KEY;
      BASE_URL = BASE_URL;
      ASSISTANT_ID = ASSISTANT_ID;
    });
    var apiThread = await CustomService.createThread(api_key: API_KEY);
    setState(() {
      thread = apiThread;

      //print(thread);
    });
  }

  Future<void> fetchMessages() async {
    print("pressed");
    setState(() {
      isLoading = true;
    });

    try {
      print(thread);
      await CustomService.createMessage(
          api_key: API_KEY,
          base_url: BASE_URL,
          thread: thread,
          message: textEditingController.text);
      textEditingController.clear();

      String runId = await CustomService.createRun(
          thread: thread, api_key: API_KEY, assistant_id: ASSISTANT_ID);

      bool isCompleted = false;
      int attempts = 0;
      const maxAttempts = 9; // Maksimum deneme sayısı
      while (!isCompleted && attempts < maxAttempts) {
        await Future.delayed(
            Duration(seconds: 2)); // Her deneme arasında bekleme süresi
        String status = await CustomService.runSteps(
            thread: thread, runId: runId, api_key: API_KEY, base_url: BASE_URL);
        isCompleted = status == "completed";
        if (!isCompleted) {
          print("Deneme $attempts: Durum $status");
        }
        attempts++;
      }

      if (isCompleted) {
        message = await CustomService.getMessagesValue(
            thread: thread, api_key: API_KEY, base_url: BASE_URL);
        setState(() {
          isLoading = false;
          message = message;
        });
      } else {
        throw Exception("Mesaj alınamadı. İşlem tamamlanamadı.");
      }
    } catch (error) {
      print("Hata: $error");
      setState(() {
        isLoading = false;
        message = "Bir hata oluştu";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const AppbarIstun(),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ShaderMask(
                shaderCallback: (Rect rect) {
                  return const LinearGradient(colors: <Color>[
                    Colors.white,
                    Colors.yellow,
                    Colors.white,
                    Colors.yellow,
                    Colors.white,
                    Colors.yellow,
                  ], begin: Alignment.topLeft, end: Alignment.bottomRight)
                      .createShader(rect);
                },
                child: Text(
                  "Asistan",
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: message != null
                    ? CustomChatWidget(msg: message!)
                    : SizedBox.shrink()
                /* SelectableText(message ?? '', style: CustomColors.barStyle), */
                ),
            Column(
              mainAxisAlignment:
                  MainAxisAlignment.end, // İkinci Column'u en alta hizala
              children: [
                if (isLoading) ...[
                  const SpinKitThreeBounce(
                    color: CustomColors.white,
                    size: 18,
                  ),
                ],
                Material(
                  color: CustomColors.cardColor,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            focusNode: focusNode,
                            cursorColor: CustomColors.white,
                            style: TextStyle(color: CustomColors.white),
                            controller: textEditingController,
                            onSubmitted: (value) async {
                              fetchMessages;
                              //  await CustomService.createMessage(message: textEditingController.text);
                            },
                            decoration: InputDecoration.collapsed(
                              hintText: "Nasıl Yardımcı Olabilirim?",
                              hintStyle: TextStyle(color: CustomColors.grey),
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: fetchMessages,
                            icon: Icon(Icons.send, color: CustomColors.white))
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
