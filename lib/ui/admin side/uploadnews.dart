import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/ui/mediaScreens/newsUploaded.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

class UploadNews extends StatefulWidget {
  const UploadNews({super.key});

  @override
  State<UploadNews> createState() => _UploadNewsState();
}

class _UploadNewsState extends State<UploadNews> {
  String? selectedItem; // Define a variable to hold the selected item

  TextEditingController decriptionController = TextEditingController();

// Dropdown items
  List<String> items = [
    'Sports',
    'Programming',
    'Media',
    'Art',
  ];
  @override
  Widget build(BuildContext context) {
    final methodsProvider=Provider.of<Methods>(context);
    return Scaffold(
      appBar: AppBar(title: Text("Upload News")),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CustomContainer(
                      height: 200,
                      width: 250,
                      border: Border.all(
                        color: const Color.fromRGBO(0, 0, 0, 1),
                      ),
                      child: Column(
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            child: Image.asset("lib/assests/images/image.png"),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          sampleText(
                              text:
                                  "Upload images or videos from gallery or camera",
                              fontsize: 10,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.bold),
                        ],
                      )),
                ),
                sampleText(text: "Enter Description:"),
                TextFormField(
                  controller: decriptionController,
                  decoration: InputDecoration(
                    // hintText: 'Enter Description',
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius for desired roundness
                      borderSide:
                          BorderSide(color: Colors.grey), // Border color
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius for desired roundness
                      borderSide: BorderSide(
                          color: Colors.grey), // Focused border color
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the radius for desired roundness
                      borderSide: BorderSide(
                          color:
                              Colors.grey), // Enabled (inactive) border color
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () => methodsProvider.speak(decriptionController.text),
                  child: Container(
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black)),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          child: Image.asset(
                              "lib/assests/images/chatpgt icon 1.png"),
                        ),
                        sampleText(text: "Chatgpt", fontWeight: FontWeight.bold)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                sampleText(text: "Select Tag:"),
                SizedBox(
                  height: 20,
                ),
                DropdownButton<String>(
                  value: selectedItem, // Initially selected item (if any)
                  hint: Text('Select an item'), // Placeholder or hint text
                  isExpanded: true, // Expand dropdown to fit maximum width
                  style: TextStyle(
                      color: Colors
                          .grey), // Set dropdown button text color to grey
                  underline: Container(
                    height: 2,
                    color: Colors.grey, // Set the underline color to grey
                  ),
                  onChanged: (newValue) {
                    // Callback function to handle the item selection
                    setState(() {
                      selectedItem = newValue; // Update the selected item
                    });
                  },
                  items: items.map((String item) {
                    return DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: TextStyle(
                            color: Colors
                                .grey), // Set dropdown item text color to grey
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(
                  height: 100,
                ),
                Center(
                  child: button(
                      title: "Done",
                      ontap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsUploaded(),
                            ));
                      }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
