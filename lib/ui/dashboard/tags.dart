import 'package:ai_news_caster/modals/news_modals.dart';
import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/ui/mediaScreens/newsScreen.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tags extends StatefulWidget {
  final String category;
  const Tags({Key? key, required this.category}) : super(key: key);

  @override
  State<Tags> createState() => _TagsState();
}

class _TagsState extends State<Tags> {
  @override
  Widget build(BuildContext context) {
    final methodsProvider = Provider.of<Methods>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} News'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            FutureBuilder<NewsModel>(
              future: methodsProvider.getNewsByCategory(widget.category),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  debugPrint(snapshot.error.toString());
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.articles == null) {
                  return const Center(child: Text("No data available"));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: snapshot.data!.articles!.length,
                  itemBuilder: (context, index) {
                    final doc = snapshot.data!.articles![index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => NewsScreen(article: doc),
                          ),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                color: Color.fromARGB(255, 19, 85, 139),
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.only(bottom: 15, left: 10, right: 10),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Container(
                                    width: 100,
                                    height: 150,
                                    color: Colors.brown,
                                    child: Image.network(
                                      doc.urlToImage != null && doc.urlToImage != ""
                                          ? doc.urlToImage!
                                          : 'https://i.pinimg.com/564x/4e/d1/26/4ed126ab70265d07682cba1995385822.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        sampleText(
                                          text: doc.title.toString(),
                                          fontsize: 13,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Image.asset("lib/assests/images/mark.png", fit: BoxFit.cover),
                                            const SizedBox(width: 10),
                                            Container(
                                              height: 20,
                                              width: 100,
                                              child: sampleText(
                                                text: doc.source!.name.toString(),
                                                fontsize: 12,
                                                overflow: TextOverflow.fade,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                ),
                                const Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(5.0),
                                      child: Icon(
                                        Icons.favorite,
                                        color: Color(0xFFBD1616),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
