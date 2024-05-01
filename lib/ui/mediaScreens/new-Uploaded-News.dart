import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/ui/mediaScreens/newsScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewNews extends StatefulWidget {
  const NewNews({super.key});

  @override
  State<NewNews> createState() => _NewNewsState();
}

class _NewNewsState extends State<NewNews> {
  @override
  Widget build(BuildContext context) {
    final methodsProvider = Provider.of<Methods>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Whats New"),
      ),
      body: FutureBuilder(
        future: methodsProvider.getCollectionData(),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<dynamic> allNewsData = snapshot.data!;
            return ListView.builder(
              itemCount: allNewsData.length,
              itemBuilder: (BuildContext context, int index) {
                var newsData = allNewsData[index];
                List<dynamic> imagePaths = newsData['image path'];
                String firstImagePath = imagePaths.isNotEmpty
                    ? imagePaths[0]
                    : ''; // Get the first image path

                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsScreen(),
                        ));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: const [
                          BoxShadow(
                            blurRadius: 10,
                            color: Color.fromARGB(255, 19, 85, 139),
                          )
                        ],
                      ),
                      margin: const EdgeInsets.only(
                          bottom: 15, left: 10, right: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
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
                                child: firstImagePath.isNotEmpty
                                    ? FadeInImage(
                                        placeholder: AssetImage(
                                            'lib/assests/images/loader.jpg'), // Placeholder image
                                        image: NetworkImage(
                                            firstImagePath), // Actual image
                                        fit: BoxFit.cover,
                                        // If the image fails to load, display the placeholder image
                                        imageErrorBuilder:
                                            (context, error, stackTrace) {
                                          return Image.asset(
                                              'lib/assests/images/loader.jpg',
                                              fit: BoxFit.cover);
                                        },
                                      )
                                    : Center(
                                        child:
                                            CircularProgressIndicator()), // Loading indicator
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Title: ${newsData['title']}'),
                                    Text(
                                        'Description: ${newsData['description']}'),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                            "lib/assests/images/mark.png",
                                            fit: BoxFit.cover),
                                        const SizedBox(width: 10),
                                        Container(
                                          height: 20,
                                          width: 100,
                                          child: Text(
                                            'Tag: ${newsData['tag']}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                overflow: TextOverflow.fade,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          //  sampleText(
                                          //     text: doc.source!.name.toString(),
                                          //     fontsize: 12,
                                          //     overflow: TextOverflow.fade,
                                          //     fontWeight: FontWeight.w500),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
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
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
