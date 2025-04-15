import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_app/colors.dart';
import '../controllers/news_controller.dart';
import '../components/newsCard.dart';
import '../helpers/category_helper.dart';
import 'package:url_launcher/url_launcher.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final NewsController newsController = Get.put(NewsController());
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    String category = CategoryHelper.categories[index];
    newsController.fetchArticles(category: category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.myBackgroundColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Top News",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
                color: AppColors.myColor,
              ),
            ),
          ],
        ),
      ),
      body: Obx(
        () =>
            newsController.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                  separatorBuilder:
                      (context, index) => const SizedBox(height: 2),
                  physics: const BouncingScrollPhysics(),
                  itemCount: newsController.newsArticles.length,
                  itemBuilder:
                      (context, index) => InkWell(
                        onTap: () async {
                          final url = newsController.newsArticles[index].url;
                          if (url.isNotEmpty) {
                            if (await canLaunchUrl(Uri.parse(url))) {
                              await launchUrl(Uri.parse(url));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Could not launch the URL'),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Invalid or empty URL')),
                            );
                          }
                        },
                        child: NewsCard(
                          title: newsController.newsArticles[index].title,
                          description:
                              newsController.newsArticles[index].description,
                          imageUrl:
                              newsController.newsArticles[index].urlToImage ??
                              "",
                          author:
                              newsController.newsArticles[index].author ?? "",
                          publishedAt:
                              newsController.newsArticles[index].publishedAt
                                  .toString(),
                        ),
                      ),
                ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.myColor,
        unselectedItemColor: AppColors.myunselectedItemColor,
        items: List.generate(CategoryHelper.categories.length, (index) {
          final category = CategoryHelper.categories[index];
          return BottomNavigationBarItem(
            icon: Icon(CategoryHelper.getIconForCategory(category)),
            label: CategoryHelper.getLabelForCategory(category),
          );
        }),
      ),
    );
  }
}
