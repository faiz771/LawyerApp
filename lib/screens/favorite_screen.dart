import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/controllers/blog_controller.dart';
import 'package:lawyerapp/screens/articles_screen.dart';
import 'package:lawyerapp/screens/blog_podcast.dart';
import 'package:lawyerapp/screens/blog_videos.dart';
import 'package:lawyerapp/utils/app_colors.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen>
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
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColor.teelColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.favorite,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        bottom: TabBar(
          labelStyle:
              const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          indicatorColor: Colors.white,
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
            isFromFavorite: true,
          ),
          VideoList(
            isFromFavorite: true,
          ),
          PodcastList(
            isFromFavorite: true,
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

class BlogPostContainer extends StatelessWidget {
  const BlogPostContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                // Handle onTap on user avatar
                print('User Avatar Tapped');
              },
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/onboard1.jpg'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Micheal Clark',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/onboarding1.jpg', // Replace with your image asset
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            const Text(
              'Blog Title', // Replace with your title
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Blog Description Lorem ipsum dolor sit amet, consectetur adipiscing elit. ...', // Replace with your description
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
