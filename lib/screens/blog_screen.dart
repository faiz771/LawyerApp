import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lawyerapp/screens/blog_podcast.dart';
import 'package:lawyerapp/screens/blog_videos.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class BlogScreen extends StatefulWidget {
  @override
  _BlogScreenState createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  final List<VideoItem> videos = [
    VideoItem(videoUrl: 'video_url_1', title: 'This is Video title 1'),
    VideoItem(videoUrl: 'video_url_2', title: 'This is video title 2'),
    // Add more video items as needed
  ];
  final List<PodcastItem> podcasts = [
    PodcastItem(
      title: 'Podcast Title 1',
      description: 'Description of Podcast 1',
      imageUrl: 'https://example.com/podcast1.jpg',
    ),
    PodcastItem(
      title: 'Podcast Title 2',
      description: 'Description of Podcast 2',
      imageUrl: 'https://example.com/podcast2.jpg',
    ),
    // Add more PodcastItem objects as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Blogs',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        bottom: TabBar(
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          indicatorColor: AppColor.teelColor,
          controller: _tabController,
          tabs: [
            Tab(text: 'Articles', icon: Icon(Icons.article)),
            Tab(text: 'Videos', icon: Icon(Icons.video_library)),
            Tab(text: 'Podcasts', icon: Icon(Icons.headset)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ArticleListScreen(),
          VideoList(videos: videos),
          PodcastList(podcasts: podcasts),
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

class Article {
  final String title;
  final String description;
  final String imageUrl;

  Article({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class ArticleListScreen extends StatelessWidget {
  final List<Article> articles = [
    Article(
      title: 'Article 1',
      description:
          'This is a brief description of Article 1. It provides an overview of the article content.',
      imageUrl:
          'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg',
    ),
    Article(
      title: 'Article 2',
      description:
          'This is a brief description of Article 2. It provides an overview of the article content.',
      imageUrl:
          'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg',
    ),
    Article(
      title: 'Article 3',
      description:
          'This is a brief description of Article 3. It provides an overview of the article content.',
      imageUrl:
          'https://www.simplilearn.com/ice9/free_resources_article_thumb/what_is_image_Processing.jpg',
    ),
    // Add more articles as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Article List'),
      // ),
      body: ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return InkWell(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => ArticleDetailsScreen(article: article),
              //   ),
              // );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
                  child: Row(
                    children: [
                      Container(
                          height: 100,
                          width: 90,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              borderRadius: BorderRadius.circular(12),
                              image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: AssetImage(
                                    'assets/images/article.png',
                                  )))),
                      SizedBox(
                        width: 12.h,
                      ),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Article Title',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              ],
                            ),
                            Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed ac tortor in velit venenatis aliquam. Nulla facilisi. Integer at nulla nec lorem posuere facilisis. Donec ullamcorper, nisi ut tempor gravida, eros nulla fermentum elit, sed congue ligula nunc nec justo. Integer nec turpis id justo sollicitudin vulputate.Phasellus auctor libero id augue fermentum, nec suscipit odio consequat. Ut a est sagittis, posuere libero nec, cursus nunc. Nam convallis, elit vel feugiat posuere, lectus orci elementum lorem, eget accumsan elit lorem id elit.Vivamus hendrerit sapien at urna pharetra, a placerat ligula tempus. Donec sit amet lorem et lectus scelerisque tristique. Duis in dolor sem. Vivamus sodales vel mauris ac consequat. Donec commodo tincidunt nunc, nec posuere sem tincidunt id. Nulla facilisi.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
