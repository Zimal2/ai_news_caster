import 'package:ai_news_caster/provider/Methods.dart';
import 'package:ai_news_caster/ui/admin%20side/gemini.dart';
import 'package:ai_news_caster/ui/mediaScreens/newsUploaded.dart';
import 'package:ai_news_caster/widgets/button.dart';
import 'package:ai_news_caster/widgets/containers.dart';
import 'package:ai_news_caster/widgets/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class UploadNews extends StatefulWidget {
  int uploadedImagesCount = 0;
  // Define a list to store selected images
  List<File?> selectedImages = [];
  List<String> ImagesToFirebase = [];

  String? useridA;
  UploadNews({super.key, required this.useridA});

  @override
  State<UploadNews> createState() => UploadNewsState();
}

class UploadNewsState extends State<UploadNews> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final methodsProvider = Provider.of<Methods>(context);
    double size = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Upload News",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (widget.selectedImages.length < 4) {
                        methodsProvider.pickImage(context).then((image) {
                          // Update the selected images list with the newly picked image
                          if (methodsProvider.image != null) {
                            setState(() {
                              //add selected images to list to upload into firebase
                              widget.ImagesToFirebase.add(
                                  methodsProvider.urlDownload.toString());
                              print("urlDownload: ${widget.ImagesToFirebase}");
                              widget.selectedImages.add(methodsProvider.image);
                            });
                          }
                        });
                      }
                      widget.uploadedImagesCount++;
                    },
                    child: CustomContainer(
                      height: 200,
                      width: 250,
                      border: Border.all(
                        color: Colors.black,
                      ),
                      child: Column(
                        children: [
                          methodsProvider.isUploadingImage
                              ? CircularProgressIndicator()
                              : methodsProvider.image != null
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
                                          "lib/assests/images/uploadImage.png"),
                                    ),
                          const SizedBox(
                            height: 5,
                          ),
                          Column(
                            children: [
                              sampleText(
                                text: "Click on above icon to upload",
                                fontsize: 12,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.bold,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              sampleText(
                                text: "Note:  Max Images: 4",
                                fontsize: 10,
                                color: Colors.red,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                // Row to track the number of images uploaded
                Row(
                  children: [
                    for (int index = 0;
                        index < widget.selectedImages.length;
                        index++)
                      Padding(
                        padding: const EdgeInsets.only(right: 2),
                        child: Stack(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.12,
                              width: MediaQuery.of(context).size.width * 0.20,
                            ),
                            Positioned(
                              top: 7,
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.09,
                                width: MediaQuery.of(context).size.width * 0.15,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Image.file(
                                  widget.selectedImages[index]!,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              right: 5,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    // Remove the image from the selectedImages list
                                    widget.ImagesToFirebase.removeAt(index);
                                    widget.selectedImages.removeAt(index);
                                  });
                                },
                                child: Container(
                                  width: 25,
                                  height: 25,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                //title
                sampleText(text: "Enter title:"),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter title';
                    }
                    return null;
                  },
                  controller: methodsProvider.titleController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //description
                sampleText(text: "Enter Description:"),
                TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter description';
                    }
                    return null;
                  },
                  controller: methodsProvider.decriptionController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                //chatgpt option
                GestureDetector(
                  onTap: () async {
                    final response = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Gemini(),
                        ));

                    if (response != null && response is String) {
                      // Update the description TextFormField with the AI response
                      methodsProvider.decriptionController.text = response;
                    }
                  },

                  //  methodsProvider
                  //     .speak(methodsProvider.decriptionController.text),
                  child: Container(
                    height: 50,
                    width: 130,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black)),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(35),
                            child: Image.asset(
                              "lib/assests/images/gemini_logo.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.01,
                        ),
                        sampleText(text: "Gemini", fontWeight: FontWeight.bold)
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
                    value: methodsProvider.selectedItem,
                    hint: const Text('Select an item'),
                    isExpanded: true,
                    style: const TextStyle(color: Colors.grey),
                    underline: Container(
                      height: 2,
                      color: Colors.grey,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        methodsProvider.selectedItem = newValue;
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
                        methodsProvider.newsUploadToFirebase(
                            context, widget.useridA, widget.ImagesToFirebase);
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
