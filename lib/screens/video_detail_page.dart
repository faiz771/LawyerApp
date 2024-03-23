import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/controllers/favorite_controller.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatefulWidget {
  String title;
  String videoUrl;
  String description;
  int blogId;
  bool isFavorite;
  VideoDetailPage(
      {super.key,
      required this.isFavorite,
      required this.blogId,
      required this.description,
      required this.title,
      required this.videoUrl});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool localvalue = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      localvalue = widget.isFavorite;
    });
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl);
    _chewieController = ChewieController(
      aspectRatio: 16 / 9,
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  final FavoriteController controller = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: localvalue
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: Colors.red,
                              ),
                        onPressed: () {
                          setState(() {
                            localvalue = !localvalue;
                          });
                          !localvalue
                              ? controller
                                  .removeFromFavorites(widget.blogId.toString())
                              : controller.addToFavorites(widget.blogId);
                        },
                      ),
                    ],
                  ),
                ),
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.clip,
                ),
                const SizedBox(height: 16),
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Chewie(
                    controller: _chewieController,
                  ),
                ),
                // Container(
                //   child: BetterPlayerPlaylist(
                //     betterPlayerConfiguration: BetterPlayerConfiguration(
                //       // deviceOrientationsOnFullScreen: [
                //       //   DeviceOrientation.portraitUp,
                //       // ],
                //       autoDetectFullscreenDeviceOrientation: true,
                //       fit: BoxFit.contain,
                //       aspectRatio: 16 / 9,
                //       autoPlay: true,
                //       controlsConfiguration: BetterPlayerControlsConfiguration(
                //         enableProgressBar: true,
                //         // progressBarHandleColor: Colors.black,
                //         // progressBarPlayedColor: AppColors.yellocolor,
                //         loadingColor: AppColor.teelColor,
                //         controlBarColor: Colors.white.withAlpha(800),
                //         iconsColor: Colors.white,
                //       ),
                //     ),
                //     betterPlayerPlaylistConfiguration:
                //         const BetterPlayerPlaylistConfiguration(
                //       loopVideos: false,
                //     ),
                //     betterPlayerDataSourceList: [
                //       BetterPlayerDataSource(
                //           BetterPlayerDataSourceType.network, videoUrl),
                //     ],
                //   ),
                //   // Your video player widget goes here
                //   // Example: VideoPlayerWidget(),
                // ),
                const SizedBox(height: 16),
                const Text(
                  'Description:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed pulvinar libero at neque varius, at aliquet purus interdum. Integer eleifend arcu at justo eleifend, at posuere odio maximus. Aenean eu fermentum eros. Duis lacinia nunc id quam elementum, ut dapibus arcu fringilla. Integer eleifend arcu at justo eleifend, at posuere odio maximus. Aenean eu fermentum eros. Duis lacinia nunc id quam elementum, ut dapibus arcu fringilla. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed pulvinar libero at neque varius, at aliquet purus interdum. Integer eleifend arcu at justo eleifend, at posuere odio maximus. Aenean eu fermentum eros. Duis lacinia nunc id quam elementum, ut dapibus arcu fringilla. Integer eleifend arcu at justo eleifend, at posuere odio maximus. Aenean eu fermentum eros. Duis lacinia nunc id quam elementum, ut dapibus arcu fringilla.',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.clip,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
