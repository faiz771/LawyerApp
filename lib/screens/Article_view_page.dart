import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/controllers/favorite_controller.dart';
import 'package:video_player/video_player.dart';

class ArticleDetailPage extends StatefulWidget {
  String title;
  String imageUrl;
  String description;
  int blogId;
  bool isFavorite;
  ArticleDetailPage(
      {super.key,
      required this.isFavorite,
      required this.blogId,
      required this.description,
      required this.title,
      required this.imageUrl});

  @override
  State<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends State<ArticleDetailPage> {
  late VideoPlayerController _videoPlayerController;

  late ChewieController _chewieController;
  bool localvalue = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      localvalue = widget.isFavorite;
    });
    _videoPlayerController = VideoPlayerController.network(
        'https://www.example.com/sample_video.mp4');
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  final FavoriteController controller = Get.put(FavoriteController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], //
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
                // AspectRatio(
                //   aspectRatio: 16 / 9,
                //   child: Container(
                //     decoration: BoxDecoration(
                //         color: Colors.white,
                //         borderRadius: BorderRadius.circular(8),
                //         boxShadow: [
                //           BoxShadow(
                //             color: Colors.grey.withOpacity(0.5),
                //             spreadRadius: 5,
                //             blurRadius: 7,
                //             offset: const Offset(0, 3),
                //           ),
                //         ],
                //         image: DecorationImage(image: )),
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          widget.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Description:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.description,
                  style: const TextStyle(
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
