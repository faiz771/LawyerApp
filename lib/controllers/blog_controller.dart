import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lawyerapp/models/article_model.dart';
import 'package:lawyerapp/models/podcast_model.dart';
import 'package:lawyerapp/models/videos_model.dart';
import 'package:lawyerapp/shared_preference/shared_preference_services.dart';
import 'package:lawyerapp/utils/api_base_url.dart';

class BlogController extends GetxController {
  RxBool isTrue = false.obs;
  String url = '${Api.ApiBaseUrl}/blogs/articals';
  final SharedPreferencesService prefsService = SharedPreferencesService();

  RxBool isLoading = false.obs;
  RxList<Article> articles = <Article>[].obs;

  Future<void> fetchArticles() async {
    isLoading.value = true;

    final String? token = await prefsService.getToken();
    print('Fetching articles from: $url');
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer $token', // Include the bearer token in the headers
        },
      );
      print('Response status code: ${response.statusCode}');
      final responseData = json.decode(response.body);
      print('Response data: $responseData');
      if (responseData['status'] == 1) {
        isLoading.value = false;
        Iterable articlesData = responseData['data'];
        articles.value = articlesData.map((e) => Article.fromJson(e)).toList();
        print('Fetched ${articles.length} articles successfully');
      } else {
        print('Failed to fetch articles: ${responseData['message']}');
      }
    } catch (error) {
      print('Error fetching articles: $error');
    }
  }

  RxList<Video> videos = <Video>[].obs;

  Future<void> fetchVideos() async {
    isLoading.value = true;
    String url = '${Api.ApiBaseUrl}/blogs/videos';
    print('Fetching videos from: $url');
    final String? token = await prefsService.getToken();
    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization':
              'Bearer $token', // Include the bearer token in the headers
        },
      );
      print('Response status code: ${response.statusCode}');
      final responseData = json.decode(response.body);
      print('Response data: $responseData');
      if (responseData['status'] == 1) {
        isLoading.value = false;
        Iterable videosData = responseData['data'];
        videos.value = videosData.map((e) => Video.fromJson(e)).toList();
        print('Fetched ${videos.length} videos successfully');
      } else {
        print('Failed to fetch videos: ${responseData['message']}');
      }
    } catch (error) {
      print('Error fetching videos: $error');
    }
  }

  RxList<PodcastItem> podcasts = <PodcastItem>[].obs;
  void fetchPodcasts() async {
    String url = '${Api.ApiBaseUrl}/blogs/podcasts';
    print('Fetching podcast from: $url');
    final String? token = await prefsService.getToken();
    try {
      var response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      final responseData = json.decode(response.body);
      print('Response data: $responseData');
      if (response.statusCode == 200) {
        isLoading.value = false;
        // List<dynamic> podcastData = responseData['data'];
        Iterable podcastsData = responseData['data'];
        podcasts.value =
            podcastsData.map((e) => PodcastItem.fromJson(e)).toList();
        // podcasts.assignAll(
        //   podcastsData.map((json) => PodcastItem.fromJson(json)).toList(),
        // );
        print('Fetched ${podcasts.length} podcasts');
      } else {
        // Handle error
        print('Failed to fetch podcasts: ${response.statusCode}');
      }
    } catch (e) {
      // Handle error
      print('Error fetching podcasts: $e');
    }
  }
}
