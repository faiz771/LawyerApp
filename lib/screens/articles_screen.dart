import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/controllers/blog_controller.dart';
import 'package:lawyerapp/models/article_model.dart';
import 'package:lawyerapp/screens/Article_view_page.dart';
import 'package:lawyerapp/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ArticleListScreen extends StatelessWidget {
  final bool isFromFavorite;
  ArticleListScreen({Key? key, required this.isFromFavorite}) : super(key: key);

  final BlogController articleController = Get.put(BlogController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        List<Article> filteredArticles = articleController.articles;
        if (isFromFavorite) {
          filteredArticles = filteredArticles
              .where((article) => article.is_favorite == 1)
              .toList();
        }

        return articleController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColor.teelColor,
                ),
              )
            : filteredArticles.isEmpty
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Center(
                      child: Text(
                        isFromFavorite
                            ? AppLocalizations.of(context)!.no_favorite_articles
                            : AppLocalizations.of(context)!
                                .no_available_articles,
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredArticles.length,
                    itemBuilder: (context, index) {
                      final Article article = filteredArticles[index];
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
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          child: InkWell(
                            onTap: () {
                              Get.to(ArticleDetailPage(
                                  isFavorite: article.is_favorite == 1,
                                  blogId: article.id,
                                  description: article.content,
                                  title: article.title,
                                  imageUrl: article.mediaAppPath));
                            },
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
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.w, vertical: 12.h),
                                child: Row(
                                  children: [
                                    Container(
                                        height: 100,
                                        width: 90,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black, width: 2),
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                filterQuality:
                                                    FilterQuality.low,
                                                image: NetworkImage(
                                                  article.mediaAppPath,
                                                )))),
                                    SizedBox(
                                      width: 12.h,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  article.title,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const Divider(
                                            thickness: 1,
                                            color: Colors.grey,
                                          ),
                                          Text(
                                            article.content,
                                            style: const TextStyle(
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
                        ),
                      );
                    },
                  );
      },
    );
  }
}
