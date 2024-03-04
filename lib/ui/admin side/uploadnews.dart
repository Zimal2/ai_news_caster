import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:io';



class UploadNews extends StatefulWidget {
  int uploadedImagesCount = 0;

 // Define a list to store selected images
List<File?> selectedImages = []; 
 String? useridA;
  UploadNews({super.key, required this.useridA});

  @override
  State<UploadNews> createState() => _UploadNewsState();
}

class _UploadNewsState extends State<UploadNews> {
  @override
  Widget build(BuildContext context) {
    final methodsProvider = Provider.of<Methods>(context);
    double size = MediaQuery.of(context).size.height;
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
                  child: GestureDetector(
                    onTap: () {
                      widget.uploadedImagesCount++;
                      methodsProvider.pickImage(context);
                    },
                    child: CustomContainer(
                      height: 200,
                      width: 250,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      child: Column(
                        children: [
                          methodsProvider.image != null
                              ? Image.file(
                                  methodsProvider.image!,
                                  width: 150,
                                  height: 150,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  width: 150,
                                  height: 150,
                                  child: Image.asset(
                                      "lib/assests/images/image.png"),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          sampleText(
                            text: "Upload images from gallery(maximum 4)",
                            fontsize: 10,
                            textAlign: TextAlign.center,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Define a variable to track the number of images uploaded

               

// Inside your widget build method or function
Row(
  children: [
    // Display previously selected images
    for (int i = 0; i <widget.selectedImages.length; i++)
      Image.file(
        widget.selectedImages[i]!,
        height: MediaQuery.of(context).size.height * 0.12,
        width: MediaQuery.of(context).size.width * 0.2,
        fit: BoxFit.cover,
      ),
    
    // Display a placeholder or add new image button
    if (widget.selectedImages.length < 4)
      GestureDetector(
        onTap: () {
          // Call the method to pick an image
          
          methodsProvider.pickImage(context).then((image) {
            // Update the selected images list with the newly picked image
            if (methodsProvider.image  != null) {
              setState(() {
                widget.selectedImages.add(methodsProvider.image );
              });
            }
          });
        },
        child: Container(
          width: 150,
          height: 150,
          child: Image.asset("lib/assests/images/image.png"),
        ),
      ),
  ],
),


                SizedBox(
                  height: 10,
                ),

                SizedBox(
                  height: 20,
                ),
                //title
                sampleText(text: "Enter title:"),
                TextFormField(
                  controller: methodsProvider.titleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //description
                sampleText(text: "Enter Description:"),
                TextFormField(
                  controller: methodsProvider.decriptionController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //chatgpt option
                GestureDetector(
                  onTap: () => methodsProvider
                      .speak(methodsProvider.decriptionController.text),
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
                const SizedBox(
                  height: 20,
                ),
                sampleText(text: "Select Tag:"),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5),
                  child: DropdownButton<String>(
                    elevation: 2,
                    focusColor: Colors.grey,

                    value: methodsProvider
                        .selectedItem, // Initially selected item (if any)
                    hint: Text('Select an item'), // Placeholder or hint text
                    isExpanded: true, // Expand dropdown to fit maximum width
                    style: const TextStyle(
                        color: Colors
                            .grey), // Set dropdown button text color to grey
                    underline: Container(
                      height: 2,
                      color: Colors.grey, // Set the underline color to grey
                    ),
                    onChanged: (newValue) {
                      // Callback function to handle the item selection
                      setState(() {
                        methodsProvider.selectedItem =
                            newValue; // Update the selected item
                      });
                    },
                    items: methodsProvider.items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: size * 0.05,
                ),
                Center(
                  child: button(
                      title: "Done",
                      ontap: () {
                        debugPrint(
                            "useridA in upload class: ${widget.useridA ?? 'nothing'}");

                        methodsProvider.newsUploadToFirebase(
                            context, widget.useridA);
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
