import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/controllers/blog_controller.dart';
import 'package:lawyerapp/screens/videos_model.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class VideoList extends StatelessWidget {
  VideoList({
    Key? key,
  }) : super(key: key);
  final BlogController blogController = Get.put(BlogController());
  @override
  Widget build(BuildContext context) {
    return Obx(() => blogController.isLoading.value
        ? Center(
            child: CircularProgressIndicator(
              color: AppColor.teelColor,
            ),
          )
        : ListView.builder(
            itemCount: blogController.videos.length,
            itemBuilder: (context, index) {
              final Video videos = blogController.videos[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: VideoItemContainer(video: videos),
              );
            },
          ));
  }
}

class VideoItemContainer extends StatelessWidget {
  final Video video;

  const VideoItemContainer({Key? key, required this.video}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(video.mediaAppPath);
    return Container(
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
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: BetterPlayerPlaylist(
                betterPlayerConfiguration: BetterPlayerConfiguration(
                  // deviceOrientationsOnFullScreen: [
                  //   DeviceOrientation.portraitUp,
                  // ],
                  autoDetectFullscreenDeviceOrientation: true,
                  fit: BoxFit.fitHeight,
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  controlsConfiguration: BetterPlayerControlsConfiguration(
                    enableProgressBar: true,
                    // progressBarHandleColor: Colors.black,
                    // progressBarPlayedColor: AppColors.yellocolor,
                    loadingColor: AppColor.teelColor,
                    controlBarColor: Colors.white.withAlpha(800),
                    iconsColor: Colors.white,
                  ),
                ),
                betterPlayerPlaylistConfiguration:
                    const BetterPlayerPlaylistConfiguration(
                  loopVideos: false,
                ),
                betterPlayerDataSourceList: [
                  BetterPlayerDataSource(
                    BetterPlayerDataSourceType.network,
                    video.mediaAppPath,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    video.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.favorite,
                    color: Colors.red,
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
    );
  }
}
