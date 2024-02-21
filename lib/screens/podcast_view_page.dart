import 'package:audioplayers/audioplayers.dart';
import 'package:chewie/chewie.dart' as chewie;
import 'package:chewie_audio/chewie_audio.dart' as chewie_audio;

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lawyerapp/controllers/favorite_controller.dart';
import 'package:lawyerapp/utils/app_colors.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:video_player/video_player.dart';

class PodcastDetailPage extends StatefulWidget {
  String title;
  String videoUrl;
  String description;
  bool mediaType;
  int blogId;
  bool isFavorite;
  PodcastDetailPage(
      {super.key,
      required this.blogId,
      required this.isFavorite,
      required this.description,
      required this.title,
      required this.videoUrl,
      required this.mediaType});

  @override
  State<PodcastDetailPage> createState() => _PodcastDetailPageState();
}

class _PodcastDetailPageState extends State<PodcastDetailPage> {
  late VideoPlayerController _videoPlayerController;

  late chewie.ChewieController _chewieController;
  bool localvalue = false;
  @override
  void initState() {
    super.initState();
    setState(() {
      localvalue = widget.isFavorite;
    });
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _chewieController = chewie.ChewieController(
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
            physics: BouncingScrollPhysics(),
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
                            ? Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : Icon(
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
                  "${widget.title}",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.clip,
                ),
                SizedBox(height: 16),
                widget.mediaType
                    ? AudioPlayerPage(audioUrl: widget.videoUrl)
                    : AspectRatio(
                        aspectRatio: 16 / 9,
                        child: chewie.Chewie(
                          controller: _chewieController,
                        ),
                      ),
                // Container(
                //     child: BetterPlayerPlaylist(
                //       betterPlayerConfiguration: BetterPlayerConfiguration(
                //         // deviceOrientationsOnFullScreen: [
                //         //   DeviceOrientation.portraitUp,
                //         // ],
                //         autoDetectFullscreenDeviceOrientation: true,
                //         fit: BoxFit.contain,
                //         aspectRatio: 16 / 9,
                //         autoPlay: true,
                //         controlsConfiguration:
                //             BetterPlayerControlsConfiguration(
                //           enableProgressBar: true,
                //           // progressBarHandleColor: Colors.black,
                //           // progressBarPlayedColor: AppColors.yellocolor,
                //           loadingColor: AppColor.teelColor,
                //           controlBarColor: Colors.white.withAlpha(800),
                //           iconsColor: Colors.white,
                //         ),
                //       ),
                //       betterPlayerPlaylistConfiguration:
                //           const BetterPlayerPlaylistConfiguration(
                //         loopVideos: false,
                //       ),
                //       betterPlayerDataSourceList: [
                //         BetterPlayerDataSource(
                //             BetterPlayerDataSourceType.network, videoUrl),
                //       ],
                //     ),
                //     // Your video player widget goes here
                //     // Example: VideoPlayerWidget(),
                //   ),
                SizedBox(height: 16),
                Text(
                  'Description:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
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

class AudioPlayerPage extends StatefulWidget {
  final String audioUrl;

  const AudioPlayerPage({Key? key, required this.audioUrl}) : super(key: key);

  @override
  _AudioPlayerPageState createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  late VideoPlayerController _videoPlayerController;
  late chewie_audio.ChewieAudioController _chewieAudioController;

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.audioUrl));
    _chewieAudioController = chewie_audio.ChewieAudioController(
      cupertinoProgressColors: chewie_audio.ChewieProgressColors(
        playedColor: Colors.red, // Change played color to red
        handleColor: Colors.red, // Change handle color to red
        bufferedColor: Colors.grey, // Change buffered color to grey
        backgroundColor: Colors.black, // C
      ),
      materialProgressColors: chewie_audio.ChewieProgressColors(
        playedColor: Colors.red, // Change played color to red
        handleColor: Colors.red, // Change handle color to red
        bufferedColor: Colors.grey, // Change buffered color to grey
        backgroundColor: Colors.black, // C
      ),
      showControls: true,
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: false,
    );
    _videoPlayerController.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieAudioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return chewie_audio.ChewieAudio(
      controller: _chewieAudioController,
    );
  }
}
// class MyHomePage extends StatefulWidget {
//   final String url;

//   MyHomePage({Key? key, required this.url}) : super(key: key);

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   final player = AudioPlayer();
//   Duration? _duration;
//   Duration? _position;

//   @override
//   void initState() {
//     super.initState();
//     // Load an MP3 audio file from the assets folder
//     _initAudioPlayer();
//   }

//   Future<void> _initAudioPlayer() async {
//     await player.setUrl(widget.url);
//     player.durationStream.listen((duration) => setState(() {
//           _duration = duration;
//         }));
//     player.positionStream.listen((position) => setState(() {
//           _position = position;
//         }));
//   }

//   @override
//   void dispose() {
//     // Dispose of the AudioPlayer instance when the widget is disposed
//     player.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         // Play/pause button
//         IconButton(
//           icon: Icon(player.playing ? Icons.pause : Icons.play_arrow),
//           onPressed: () {
//             player.playing ? player.pause() : player.play();
//           },
//         ),
//         // Stop button
//         IconButton(
//           icon: Icon(Icons.stop),
//           onPressed: () {
//             player.stop();
//           },
//         ),
//         // Duration slider
//         Slider(
//           value: _position?.inSeconds.toDouble() ?? 0.0,
//           onChanged: (value) {
//             final newPosition = Duration(seconds: value.toInt());
//             player.seek(newPosition);
//           },
//           min: 0.0,
//           max: _duration?.inSeconds.toDouble() ?? 0.0,
//         ),
//         // Duration display
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Text(
//             '${_position ?? Duration.zero} / ${_duration ?? Duration.zero}',
//             style: TextStyle(fontSize: 16.0),
//           ),
//         ),
//       ],
//     );
//   }
// }
