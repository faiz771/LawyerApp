import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';
import 'package:lawyerapp/utils/app_colors.dart';
import 'package:lawyerapp/utils/app_constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatController extends GetxController {
  RxString chatGptKey = ''.obs;

  Future<void> fetchChatGptKey() async {
    final SharedPreferencesService prefsService = SharedPreferencesService();
    final String? token = await prefsService.getToken();
    final url =
        Uri.parse('https://lawyer-app.azsolutionspk.com/api/user/chat/key');

    try {
      final response = await http.get(
        url,
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final data = responseData['data'];
        chatGptKey.value = data;
      } else {
        print('Failed to fetch chatGpt key: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching chatGpt key: $e');
    }
  }

  RxList<Map<String, String>> messages = <Map<String, String>>[].obs;

  Future<void> sendMessage(String message) async {
    messages
        .add({'sender': 'User', 'message': message, 'isUserMessage': "true"});

    final String apiKey = chatGptKey.toString();
    const String url = 'https://api.openai.com/v1/chat/completions';
    final Map<String, dynamic> data = {
      'model': 'gpt-3.5-turbo-0613',
      'messages': [
        {
          'role': 'assistant',
          'content': "Prompt${AppConstants.GptPrompt} \n Message: $message"
        }
      ],
      'max_tokens': 4000,
      'temperature': 0.7,
    };
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    try {
      isLoading.value = true;

      final http.Response response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        final dynamic choices = responseData['choices'];

        if (choices != null && choices is List && choices.isNotEmpty) {
          final Map<String, dynamic>? responseMessage =
              choices[0]['message'] as Map<String, dynamic>?;

          if (responseMessage != null) {
            final String? reply = responseMessage['content'] as String?;
            scrollController.jumpTo(scrollController.position.maxScrollExtent);
            if (reply != null) {
              isLoading.value = false;
              messages.add({
                'sender': 'Assistant',
                'message': reply,
                'isUserMessage': "false"
              });
              Future.delayed(const Duration(milliseconds: 100), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
              Future.delayed(const Duration(milliseconds: 100), () {
                scrollController
                    .jumpTo(scrollController.position.maxScrollExtent);
              });
            } else {
              isLoading.value = false;
              print('Reply text from ChatGPT is null');
            }
          } else {
            isLoading.value = false;
            print('Response message object from ChatGPT is null or not a map');
          }
        } else {
          isLoading.value = false;
          print('No choices found in response from ChatGPT');
        }
      } else {
        isLoading.value = false;
        print('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      isLoading.value = false;
      print('Error sending message: $e');
    }
  }

  final TextEditingController textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final isLoading = false.obs;

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatController chatController = Get.put(ChatController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chatController.fetchChatGptKey();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: AppColor.teelColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.ai_assistant,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            chatController.messages.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 120.h,
                        ),
                        Center(
                          child: Text(
                            AppLocalizations.of(context)!.welcomeAi,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: AppColor.teelColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        controller: chatController.scrollController,
                        itemCount: chatController.messages.length,
                        itemBuilder: (context, index) {
                          final bool isUserMessage =
                              chatController.messages[index]['isUserMessage'] ==
                                  'true';
                          final CrossAxisAlignment alignment = isUserMessage
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start;
                          final Color backgroundColor =
                              isUserMessage ? AppColor.teelColor : Colors.white;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Align(
                              alignment: isUserMessage
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Container(
                                padding: const EdgeInsets.all(12.0),
                                decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(
                                  chatController.messages[index]['message']!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0,
                                      color: isUserMessage
                                          ? Colors.white
                                          : AppColor.teelColor),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
            chatController.isLoading.value
                ? SpinKitThreeBounce(
                    color: AppColor.teelColor,
                    size: 35.0,
                    // controller: AnimationController(
                    //     vsync: this,
                    //     duration: const Duration(milliseconds: 1200)),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => chatController.isLoading.value
            ? const SizedBox.shrink()
            : Container(
                decoration: BoxDecoration(
                  color: AppColor.teelColor,
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(24),
                      topLeft: Radius.circular(24)),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  child: TextField(
                    controller: chatController.textController,
                    decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            color: Color.fromRGBO(17, 25, 40, 1)),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      errorStyle: const TextStyle(
                          color: Colors.red, fontWeight: FontWeight.bold),
                      fillColor: Colors.grey[200],
                      filled: true,
                      hintStyle: const TextStyle(color: Colors.black),
                      hintText: AppLocalizations.of(context)!.message,
                      suffixIcon: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: IconButton(
                          icon: Image.asset(
                            'assets/images/paper-plane.png',
                            color: AppColor.teelColor,
                            scale: 20,
                          ),
                          onPressed: () {
                            if (chatController.textController.text.isNotEmpty) {
                              final String message =
                                  chatController.textController.text;
                              print('Sending message: $message');
                              chatController.sendMessage(message);
                              chatController.textController.clear();
                              chatController.scrollController.jumpTo(
                                  chatController.scrollController.position
                                      .maxScrollExtent);
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
