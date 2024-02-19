import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/components/mytextfield.dart';
import 'package:lawyerapp/utils/app_colors.dart';
import 'package:lawyerapp/utils/app_constants.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, String>> messages = [];
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false;

  Future<void> _sendMessage(String message) async {
    setState(() {
      messages
          .add({'sender': 'User', 'message': message, 'isUserMessage': "true"});
    });

    final String apiKey = AppConstants.ChatGptKey;
    final String url = 'https://api.openai.com/v1/chat/completions';
    final Map<String, dynamic> data = {
      'model': 'gpt-3.5-turbo-0613',
      'messages': [
        {'role': 'assistant', 'content': message}
      ],
      'max_tokens': 150,
      'temperature': 0.7,
    };
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $apiKey',
    };

    try {
      setState(() {
        isLoading = true;
      });

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
            _scrollController
                .jumpTo(_scrollController.position.maxScrollExtent);
            if (reply != null) {
              setState(() {
                isLoading = false;
                messages.add({
                  'sender': 'Assistant',
                  'message': reply,
                  'isUserMessage': "false"
                });
              });
              Future.delayed(Duration(milliseconds: 100), () {
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
              });
              Future.delayed(Duration(milliseconds: 100), () {
                _scrollController
                    .jumpTo(_scrollController.position.maxScrollExtent);
              });
            } else {
              print('Reply text from ChatGPT is null');
            }
          } else {
            print('Response message object from ChatGPT is null or not a map');
          }
        } else {
          print('No choices found in response from ChatGPT');
        }
      } else {
        print('Failed to send message: ${response.statusCode}');
      }
    } catch (e) {
      print('Error sending message: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: AppColor.teelColor,
        centerTitle: true,
        title: Text(
          'AI Assistant',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          messages.isEmpty
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 200.h,
                      ),
                      Center(
                        child: Text(
                          'Welcome to Moza Al-Shehhi Law Firm\'s AI Assistant! Feel free to ask any questions you may have.',
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
                      controller: _scrollController,
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final bool isUserMessage =
                            messages[index]['isUserMessage'] == 'true';
                        final CrossAxisAlignment alignment = isUserMessage
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start;
                        final Color? backgroundColor =
                            isUserMessage ? AppColor.teelColor : Colors.white;

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Align(
                            alignment: isUserMessage
                                ? Alignment.centerRight
                                : Alignment.centerLeft,
                            child: Container(
                              padding: EdgeInsets.all(12.0),
                              decoration: BoxDecoration(
                                color: backgroundColor,
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              child: Text(
                                messages[index]['message']!,
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
          isLoading
              ? SpinKitThreeBounce(
                  color: AppColor.teelColor,
                  size: 25.0,
                  controller: AnimationController(
                      vsync: this,
                      duration: const Duration(milliseconds: 1200)),
                )
              : SizedBox(),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColor.teelColor,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(12), topLeft: Radius.circular(12)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.white),
                borderRadius: BorderRadius.circular(24),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Color.fromRGBO(17, 25, 40, 1)),
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
              errorStyle:
                  TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              fillColor: Colors.grey[200],
              filled: true,
              hintStyle: TextStyle(color: Colors.black),
              hintText: 'Message',
              suffixIcon: Padding(
                padding: const EdgeInsets.only(right: 5),
                child: IconButton(
                  icon: Image.asset(
                    'assets/images/paper-plane.png',
                    scale: 20,
                  ),
                  onPressed: () {
                    final String message = _controller.text;
                    print('Sending message: $message');
                    _sendMessage(message);
                    _controller.clear();
                    _scrollController
                        .jumpTo(_scrollController.position.maxScrollExtent);
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
