import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/ui/mediaScreens/newsScreen.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class NewsHistoryListView extends StatelessWidget {


  NewsHistoryListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final methodsProvider = Provider.of<Methods>(context);
    return FutureBuilder(
      future: methodsProvider.getPostApimethod(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          debugPrint(snapshot.error.toString());
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.articles == null) {
          return Center(child: Text("No data available"));
        }

        return ListView.builder(
          itemCount: snapshot.data!.articles!.length,
          itemBuilder: (context, index) {
            final doc = snapshot.data!.articles![index];
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
                child: Image.network(doc.urlToImage ?? 'Image'),
              ),
              title: sampleText(text: doc.description.toString(), fontsize: 13),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("lib/assests/images/mark.png", fit: BoxFit.cover),
                  const SizedBox(width: 10),
                  sampleText(text: doc.source!.name.toString(), fontsize: 12),
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.favorite,
                    color: const Color(0xFFBD1616),
                  ),
                  const SizedBox(width: 8),
                  Text(''),
                ],
              ),
            );
          },
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
