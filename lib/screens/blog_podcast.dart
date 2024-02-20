import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/controllers/blog_controller.dart';
import 'package:lawyerapp/screens/podcast_view_page.dart';

import '../models/podcast_model.dart';

class PodcastList extends StatefulWidget {
  PodcastList({
    super.key,
  });

  @override
  State<PodcastList> createState() => _PodcastListState();
}

class _PodcastListState extends State<PodcastList> {
  final BlogController controller = Get.put(BlogController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchPodcasts();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: controller.podcasts.length,
      itemBuilder: (context, index) {
        return PodcastItemContainer(podcastItem: controller.podcasts[index]);
      },
    );
  }
}

class PodcastItemContainer extends StatelessWidget {
  final PodcastItem podcastItem;

  PodcastItemContainer({super.key, required this.podcastItem});
  final BlogController controller = Get.put(BlogController());
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(PodcastDetailPage(
            isFavorite: podcastItem.is_favorite == 1 ? true : false,
            blogId: podcastItem.id,
            mediaType: podcastItem.mediaType == 'audio' ? true : false,
            description: podcastItem.content,
            title: podcastItem.title,
            videoUrl: podcastItem.mediaAppPath));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: NetworkImage(
                                podcastItem.mediaType == 'audio'
                                    ? 'https://cdn.pixabay.com/photo/2016/03/31/15/24/audio-1293262_1280.png'
                                    : podcastItem.thumbnail ?? '',
                              ),
                              fit: BoxFit.cover)),
                    ),
                    Positioned(
                      top: 70,
                      bottom: 70,
                      left: 70,
                      right: 70,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                        child: Icon(
                          Icons.play_arrow,
                          size: 35,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          podcastItem.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // const Icon(
                      //   Icons.favorite,
                      //   color: Colors.red,
                      // ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    podcastItem.content,
                    style: const TextStyle(fontSize: 14),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
