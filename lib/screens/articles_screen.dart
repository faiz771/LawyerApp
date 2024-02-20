import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lawyerapp/controllers/blog_controller.dart';
import 'package:lawyerapp/models/article_model.dart';
import 'package:lawyerapp/screens/Article_view_page.dart';
import 'package:lawyerapp/utils/app_colors.dart';

class ArticleListScreen extends StatelessWidget {
  final BlogController articleController = Get.put(BlogController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => articleController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(
                color: AppColor.teelColor,
              ),
            )
          : ListView.builder(
              itemCount: articleController.articles.length,
              itemBuilder: (context, index) {
                final Article article = articleController.articles[index];
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
                            isFavorite: article.is_favorite == 1 ? true : false,
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
                                      borderRadius: BorderRadius.circular(12),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            article.mediaAppPath,
                                          )))),
                              SizedBox(
                                width: 12.h,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            article.title,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        // Icon(
                                        //   Icons.favorite,
                                        //   color: Colors.red,
                                        // )
                                      ],
                                    ),
                                    Divider(
                                      thickness: 1,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      article.content,
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
                  ),
                );
              },
            ),
    );
  }
}
