import 'dart:convert';
import 'dart:io';

import 'package:ai_news_caster/modals/news_modals.dart';
import 'package:ai_news_caster/ui/dashboard/dashboard.dart';
import 'package:ai_news_caster/ui/mediaScreens/newsUploaded.dart';
import 'package:ai_news_caster/ui/phoneNumberconfirmed.dart';
import 'package:ai_news_caster/ui/sign_in_screens/sign_in.dart';
import 'package:ai_news_caster/ui/signup_screens/phoneNumber_confirm.dart';
import 'package:ai_news_caster/ui/admin%20side/uploadnews.dart';
import 'package:ai_news_caster/utils/flutterToast.dart';
import 'package:ai_news_caster/widgets/text_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class Methods with ChangeNotifier {
  //variables
  var userID;
  
  //firebase var
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //textfeild controllers
  final usernameController = new TextEditingController();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  final institueController = new TextEditingController();
  final designationController = new TextEditingController();
  final phoneController = new TextEditingController();
   TextEditingController decriptionController = TextEditingController();
      TextEditingController titleController = TextEditingController();

  TextEditingController phoneCodeController = TextEditingController();

  //methods

  //for signup admin
  void verify(BuildContext context) {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneController.text,
        verificationCompleted: (_) {},
        verificationFailed: (e) {
          Utils().toastMessage(e.toString());
        },
        codeSent: (String verificationId, int? token) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PhoneNumberConfirm(
                  verificationId: verificationId,
                ),
              ));
        },
        codeAutoRetrievalTimeout: (e) {
          Utils().toastMessage(e.toString());
        });
  }

  //for phonenumber confirm
  void confirmPhoneNumber(BuildContext context, String verificationId) async {
    final credentials = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: phoneCodeController.text.toString());
    try {
      await _auth.signInWithCredential(credentials);
      addSignUpAdminDetailsToFirebase();
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhoneNumberConfirmed(),
          ));
    } catch (e) {
      Utils().toastMessage(e.toString());
    }
  }

  void addSignUpAdminDetailsToFirebase() async {
    CollectionReference _information =
        FirebaseFirestore.instance.collection('SignUpAdminData');
    String userID =
        FirebaseFirestore.instance.collection('SignUpAdminData').doc().id;
    await _information.doc(userID).set({
      "Designation": designationController.text,
      "EmailAdress": emailController.text,
      "Institute": institueController.text,
      "PhoneNumber": phoneController.text,
      "UserName": usernameController.text,
      "Password": passwordController.text,
    });
  }

  


//signin admin
  void signinA(BuildContext context) async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection("SignUpAdminData")
          .where('PhoneNumber', isEqualTo: phoneController.text)
          .where('Password',
              isEqualTo: passwordController
                  .text) // Assuming the field name for the password is 'Password'
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // User found, proceed with signing in
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Sign In Success"),
              content: Text("Admin signed in successfully."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadNews(),
            ));
      } else {
        // User not found or password incorrect
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Sign In Failed"),
              content: Text("Invalid phone number or password."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Error occurred
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Sign In Failed"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("OK"),
              ),
            ],
          );
        },
      );
    }
  }
  //google sign in

  void signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    UserCredential _userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    if (_userCredential.user != null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => DashboardScreen()));
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SigninScreen()));
    }
  }

//get mews api model
  Future<NewsModel> getPostApimethod() async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/everything?q=category&apiKey=8a5ec37e26f845dcb4c2b78463734448'));
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return NewsModel.fromJson(jsonData);
    } else {
      return NewsModel.fromJson(jsonData);
    }
  }

  void showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Do you want to logout of your account?'),
          actions: [
            Textbutton(
              title: 'No', 
              color: Colors.black, 
              ontap: () {
                Navigator.of(context).pop();
              }
              ),
            Textbutton(
              title: 'Yes', 
              color: const Color(0xFFBD1616), 
              ontap: () async {
                await GoogleSignIn().signOut();
                FirebaseAuth.instance.signOut();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SigninScreen()),
                );
              }
              ),
          ],
        );
      },
    );
  }

  //text to speech
  final FlutterTts flutterTts=FlutterTts();
  speak(String text) async{
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);  //range 0.5-1.5
    await flutterTts.speak(text);
  }


//Upload news data
// Dropdown items
String? selectedItem;

  List<String> items = [
    'Sports',
    'Programming',
    'Media',
    'Entertainment',
  ];
  //News Upload data on firebase
  void newsUploadToFirebase(BuildContext context) async{
    CollectionReference _information=FirebaseFirestore.instance.collection('NewsUploadData');
    String uploaderId= FirebaseFirestore.instance.collection('NewsUploadData').doc().id;
    await _information.doc(uploaderId).set({
     "title":titleController.text ,
   //  "image path": ,
     "description": decriptionController.text,
     "tag": selectedItem?.toString()?? "",

    });
  Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsUploaded(),
                            ));

  }


  void setPicture(String value){
    var picture = value;
    notifyListeners();
  }

  void setimage(File value){
    image = value;
    notifyListeners();
  }

 UploadTask? uploadTask;
 File? image;

 Future<void> pickImage(BuildContext context, ImageSource source) async {
  try {
    ImageCache().clear();
    final image = await ImagePicker().pickImage(source: source);

    if (image == null) return;

    final imageTemporary = File(image.path);
    setimage(imageTemporary);

    final path = 'News_Image/${image.name}';
    final file = File(image.path);

    final ref = FirebaseStorage.instance.ref().child(path);
    uploadTask = ref.putFile(file);

    final snapshot = await uploadTask!.whenComplete(() {});

    final urlDownload = await snapshot.ref.getDownloadURL();

    setPicture(urlDownload);

    print('Download Link: $urlDownload');
  } on PlatformException catch (e) {
    Utils().toastMessage(e.toString());
  }
}
}
