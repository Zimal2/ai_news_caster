import 'package:ai_news_caster/ui/mediaScreens/newsScreen.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';

class NewsHistoryListView extends StatelessWidget {
  final List<NewsItem> newsItems;

  NewsHistoryListView({Key? key, required this.newsItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const NewsScreen()),
            );
          },
          leading: CustomContainer(
              width: 100,
              height: double.infinity,
              child: Image.asset(newsItems[index].imagePath, fit: BoxFit.fill)),
          title: sampleText(text: newsItems[index].description, fontsize: 13),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset("lib/assests/images/mark.png", fit: BoxFit.cover),
              const SizedBox(
                width: 10,
              ),
              sampleText(text: newsItems[index].watermark, fontsize: 12),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                newsItems[index].trailingIcon,
                color: const Color(0xFFBD1616),
              ),
              const SizedBox(width: 8),
              Text(newsItems[index].trailingText),
            ],
          ),
        );
      },
    );
  }
}

class NewsItem {
  final String imagePath;
  final String description;
  final String watermark;
  final IconData trailingIcon;
  final String trailingText;

  const NewsItem({
    required this.imagePath,
    required this.description,
    required this.watermark,
    required this.trailingIcon,
    required this.trailingText,
  });
}
