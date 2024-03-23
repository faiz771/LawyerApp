import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/controllers/blog_controller.dart';
import 'package:lawyerapp/controllers/signup_controller.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';
import 'package:lawyerapp/utils/api_base_url.dart';

class FavoriteController extends GetxController {
  final BlogController controller = Get.put(BlogController());
  Future<void> addToFavorites(int blogId) async {
    final String apiUrl = '${Api.ApiBaseUrl}/blogs/add/favourite';
    String? token = await SharedPreferencesService().getToken();
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'blog_id': blogId}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print(responseData);
        List<dynamic> messages = responseData['message'];
        String message = messages.first;
        print('this is message $message');
        showStylishBottomToast(message.toString());
        controller.fetchPodcasts();
        controller.fetchArticles();

        controller.fetchVideos();
        update();
        controller.fetchPodcasts();
        update();
        // You can handle the response here
      } else {
        showStylishBottomToast('Failed to add to favorites');
        throw Exception('Failed to add to favorites');
      }
    } catch (error) {
      print('Error: $error');
      showStylishBottomToast('Error please try again');
      rethrow;
    }
  }

  Future<void> removeFromFavorites(String blogId) async {
    final String url = '${Api.ApiBaseUrl}/blogs/favourite/$blogId/remove';
    String? token = await SharedPreferencesService().getToken();
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        List<dynamic> messages = responseData['message'];
        if (messages.isNotEmpty) {
          String message = messages.first;
          print('This is message: $message');
          showStylishBottomToast(message);
          controller.fetchPodcasts();
          controller.fetchArticles();

          controller.fetchVideos();
          update();
          controller.fetchPodcasts();
          update();
        } else {
          print('No message received');
        }
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      showStylishBottomToast('Error please try again');
      // Handle error here
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    controller.fetchPodcasts();
    controller.fetchArticles();

    controller.fetchVideos();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    controller.fetchPodcasts();
    controller.fetchArticles();

    controller.fetchVideos();
  }
}
