import 'package:flutter/material.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class VideoList extends StatelessWidget {
  final List<VideoItem> videos;

  VideoList({required this.videos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: VideoItemContainer(videoItem: videos[index]),
        );
      },
    );
  }
}

class VideoItem {
  final String videoUrl;
  final String title;

  VideoItem({required this.videoUrl, required this.title});
}

class VideoItemContainer extends StatelessWidget {
  final VideoItem videoItem;

  VideoItemContainer({required this.videoItem});

  @override
  Widget build(BuildContext context) {
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
        // border: Border.all(color: Colors.grey),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AspectRatio(
            aspectRatio: 16 / 9, // Adjust aspect ratio as needed
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      topLeft: Radius.circular(12)),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://www.techsmith.com/blog/wp-content/uploads/2021/02/video-thumbnails-hero-1.png'),
                      fit: BoxFit.cover)),
              child: Center(
                  child: Icon(
                Icons.play_arrow,
                color: Colors.white,
              )),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  videoItem.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Icon(
                  Icons.favorite,
                  color: Colors.red,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
