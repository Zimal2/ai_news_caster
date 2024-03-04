import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewsUploader extends StatefulWidget {
  @override
  _NewsUploaderState createState() => _NewsUploaderState();
}

class _NewsUploaderState extends State<NewsUploader> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  TextEditingController _newsTextController = TextEditingController();
  TextEditingController _newsTitleController = TextEditingController();

  Future<void> _uploadNews() async {
    final User? user = _auth.currentUser;
    if (user != null) {
      // Check if the current user's ID matches any ID from SignUpAdminData collection
      var signUpAdminSnapshot = await _firestore
          .collection('SignUpAdminData')
          .where('userId', isEqualTo: user.uid)
          .get();

      if (signUpAdminSnapshot.docs.isNotEmpty) {
        // If the current user ID exists in SignUpAdminData collection, upload data to NewsUploadData
        await _firestore.collection('NewsUploadData').add({
          'description':_newsTextController.text,
          'image path': ["1","2","3","4"],
          'tag':"random adding" ,
          'title':_newsTitleController.text,
          'uploaderId': user.uid,
        });
        // Show a success message or perform any necessary actions
        print('News uploaded successfully!');
      } else {
        // Handle case where current user is not authorized to upload news
        print('You are not authorized to upload news.');
      }
    } else {
      // Handle case where user is not logged in
      print('User is not logged in.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload News'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _newsTitleController,
                decoration: InputDecoration(
                  labelText: 'News Title',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _newsTextController,
                decoration: InputDecoration(
                  labelText: 'News Text',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
              ),
            ),
            ElevatedButton(
              onPressed: _uploadNews,
              child: Text('Upload News'),
            ),
          ],
        ),
      ),
    );
  }
}
