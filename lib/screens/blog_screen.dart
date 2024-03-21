import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/controllers/blog_controller.dart';
import 'package:lawyerapp/models/article_model.dart';
import 'package:lawyerapp/screens/articles_screen.dart';
import 'package:lawyerapp/screens/blog_podcast.dart';
import 'package:lawyerapp/screens/blog_videos.dart';
import 'package:lawyerapp/utils/app_colors.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen>
    with SingleTickerProviderStateMixin {
  final BlogController blogController = Get.put(BlogController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    blogController.fetchArticles();
    blogController.fetchVideos();
    blogController.fetchPodcasts();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.teelColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.blogs,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        bottom: TabBar(
          physics: BouncingScrollPhysics(),
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          indicatorColor: AppColor.teelColor,
          controller: _tabController,
          tabs: [
            Tab(
                text: AppLocalizations.of(context)!.articles,
                icon: Icon(Icons.article)),
            Tab(
                text: AppLocalizations.of(context)!.videos,
                icon: Icon(Icons.video_library)),
            Tab(
                text: AppLocalizations.of(context)!.podcasts,
                icon: Icon(Icons.headset)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ArticleListScreen(
            isFromFavorite: false,
          ),
          VideoList(
            isFromFavorite: false,
          ),
          PodcastList(
            isFromFavorite: false,
          ),
        ],
      ),
    );
  }
}

//     SingleChildScrollView(
//       child: Column(
//         children: [
//           SizedBox(
//             height: 20,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(vertical: 10),
//             child: Text(
//               'Blogs',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//             ),
//           ),
//           BlogPostContainer(),
//           BlogPostContainer()
//         ],
//       ),
//     ),
//   ),
// );

