import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/controllers/blog_controller.dart';
import 'package:lawyerapp/screens/video_detail_page.dart';
import 'package:lawyerapp/models/videos_model.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class VideoList extends StatelessWidget {
  final bool isFromFavorite;

  const VideoList({Key? key, required this.isFromFavorite}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final blogController = Get.put(BlogController());

    return Obx(() {
      if (blogController.isLoading.value) {
        return Center(
          child: CircularProgressIndicator(
            color: AppColor.teelColor,
          ),
        );
      } else {
        final List<Video> videos = blogController.videos;
        final List<Video> filteredVideos = isFromFavorite
            ? videos.where((video) => video.is_favorite == 1).toList()
            : videos;

        if (filteredVideos.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: Text(
                isFromFavorite
                    ? "You haven't added any videos to favorites."
                    : "No videos available.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        return ListView.builder(
          itemCount: filteredVideos.length,
          itemBuilder: (context, index) {
            final Video video = filteredVideos[index];
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: VideoItemContainer(video: video),
            );
          },
        );
      }
    });
  }
}

class VideoItemContainer extends StatelessWidget {
  final Video video;

  const VideoItemContainer({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(
          VideoDetailPage(
            isFavorite: video.is_favorite == 1,
            blogId: video.id,
            description: video.content,
            title: video.title,
            videoUrl: video.mediaAppPath,
          ),
        );
      },
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
                          "https://lawyer-app.azsolutionspk.com/public/blogs/${video.thumbnail}",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
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
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        video.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  video.content,
                  style: const TextStyle(fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
