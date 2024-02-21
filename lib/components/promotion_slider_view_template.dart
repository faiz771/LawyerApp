import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/controllers/blog_controller.dart';
import 'package:lawyerapp/models/article_model.dart';
import 'package:lawyerapp/models/podcast_model.dart';
import 'package:lawyerapp/models/videos_model.dart';
import 'package:lawyerapp/screens/podcast_view_page.dart';

class ArticleCarouselSlider extends StatefulWidget {
  @override
  State<ArticleCarouselSlider> createState() => _ArticleCarouselSliderState();
}

class _ArticleCarouselSliderState extends State<ArticleCarouselSlider> {
  final BlogController articleController = Get.put(BlogController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    articleController.fetchPodcasts();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => CarouselSlider.builder(
          options: CarouselOptions(
            height: 320,
            autoPlay: true,
            enableInfiniteScroll: false,
            enlargeCenterPage: false,
            viewportFraction: 1,
          ),
          itemCount: articleController.podcasts.length,
          itemBuilder: (context, index, _) {
            final PodcastItem article = articleController.podcasts[index];
            return Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {
                    Get.to(PodcastDetailPage(
                      isFavorite: article.is_favorite == 1,
                      blogId: article.id,
                      mediaType: article.mediaType == 'audio',
                      description: article.content,
                      title: article.title,
                      videoUrl: article.mediaAppPath,
                    ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Image.network(
                            article.mediaType == 'audio'
                                ? 'https://cdn.pixabay.com/photo/2016/03/31/15/24/audio-1293262_1280.png'
                                : article.thumbnail ?? '',
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 70,
                            bottom: 70,
                            left: 70,
                            right: 70,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.play_arrow,
                                size: 35,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              article.title,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              article.content,
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[700],
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ));
  }
}
