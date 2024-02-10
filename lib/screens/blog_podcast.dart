import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PodcastList extends StatelessWidget {
  final List<PodcastItem> podcasts;

  PodcastList({required this.podcasts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: podcasts.length,
      itemBuilder: (context, index) {
        return PodcastItemContainer(podcastItem: podcasts[index]);
      },
    );
  }
}

class PodcastItem {
  final String title;
  final String description;
  final String imageUrl;

  PodcastItem({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class PodcastItemContainer extends StatelessWidget {
  final PodcastItem podcastItem;

  PodcastItemContainer({required this.podcastItem});

  @override
  Widget build(BuildContext context) {
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
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
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
                          ))),
                  child: Icon(Icons.play_arrow),
                ),
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
                            'Podcast Title',
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
  }
}
