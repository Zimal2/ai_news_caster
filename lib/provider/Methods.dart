import 'dart:convert';
import 'dart:io';
import 'package:ai_news_caster/modals/news_modals.dart';
import 'package:ai_news_caster/ui/dashboard/dashboard.dart';
import 'package:ai_news_caster/ui/mediaScreens/newsUploaded.dart';
import 'package:ai_news_caster/ui/phoneNumberconfirmed.dart';
import 'package:ai_news_caster/ui/profile.dart';
import 'package:ai_news_caster/ui/sign_in_screens/sign_in-administrator.dart';
import 'package:ai_news_caster/ui/sign_in_screens/sign_in.dart';
import 'package:ai_news_caster/ui/signup_screens/phoneNumber_confirm.dart';
import 'package:ai_news_caster/ui/admin%20side/uploadnews.dart';
import 'package:ai_news_caster/utils/flutterToast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icon_snackbar/flutter_icon_snackbar.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Methods with ChangeNotifier {
  //variables
  String? userID;
  String? userIDSignin;

  //firebase var
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  //textfeild controllers
  final usernameController = TextEditingController();
  final emailController = TextEditingController();

  TextEditingController newPassForgetController = new TextEditingController();
  TextEditingController PassForgetPassPhoneNumberController =
      new TextEditingController();
  TextEditingController PhoneNumberForgetPassPhoneNumberController =
      new TextEditingController();

  final newPassController = new TextEditingController();
  final confirmPassController = new TextEditingController();
  final passwordControllerSignin = TextEditingController();
  final passwordControllerSignup = TextEditingController();

  final institueController = TextEditingController();
  final designationController = TextEditingController();

  final phoneControllerSignup = TextEditingController();
  final phoneControllerSignin = TextEditingController();

  TextEditingController decriptionController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController phoneCodeController = TextEditingController();

  //keys
  final GlobalKey<FormState> forgetFormKey = GlobalKey<FormState>();

  final GlobalKey<FormState> signUpKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool get loading => isLoading;

  setloading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  //methods
  //here
  //for signup admin
  void verify(BuildContext context) {
    if (signUpKey.currentState!.validate()) {
      try {
        setloading(true);
        _auth.verifyPhoneNumber(
            phoneNumber: phoneControllerSignup.text,
            verificationCompleted: (_) {},
            verificationFailed: (e) {
              showSnackBar(context, "Verfication Failed", SnackBarType.fail);
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
              setloading(false);
              Utils().toastMessage(e.toString());
            });
      } catch (error) {
        setloading(false);

        Utils().toastMessage("Error while Sign up");
      }
    }
  }

  //for phonenumber confirm
  void confirmPhoneNumber(BuildContext context, String verificationId) async {
    final credentials = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: phoneCodeController.text.toString());
    try {
      await _auth.signInWithCredential(credentials);
      addSignUpAdminDetailsToFirebase();
      showSnackBar(context, "Successfull Sign up", SnackBarType.success);
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PhoneNumberConfirmed(),
          ));
    } catch (e) {
      showSnackBar(context, "Sign up Failed", SnackBarType.fail);
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
      "PhoneNumber": phoneControllerSignup.text,
      "UserName": usernameController.text,
      "Password": passwordControllerSignup.text,
      "userId": userID.toString(),
    });
  }

//signin admin
  void signinA(BuildContext context) async {
    try {
      setloading(true);
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection("SignUpAdminData")
          .where('PhoneNumber', isEqualTo: phoneControllerSignin.text)
          .where('Password',
              isEqualTo: passwordControllerSignin
                  .text) // Assuming the field name for the password is 'Password'
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String userId = querySnapshot.docs[0].get('userId');
        userIDSignin = userId;

        debugPrint("User ID while sign in: ${userIDSignin}");
        showSnackBar(context, "Sign In Success", SnackBarType.success);
        //clear values of text feilds when move to next
        phoneControllerSignin.clear();
        passwordControllerSignin.clear();
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UploadNews(
                useridA: userIDSignin,
              ),
            ));
      } else {
        // User not found or password incorrect
        showSnackBar(context, "Sign In Failed", SnackBarType.fail);
        setloading(false);
      }
    } catch (e) {
      // Error occurred
      showSnackBar(context, "Sign In Failed", SnackBarType.fail);
    }
  }


  String? nameOFUser;
//profile data
  Future<String?> fetchUserNameForLoggedInUser(String email) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('UserSignUpData')
          .doc(email)
          .get();
      return userDoc['username'];
    } catch (e) {
      print('Error fetching username: $e');
      return null;
    }
  }

  Future<void> pickProfileImage(BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      print("here check 1");
      if (image == null) return;
      print("here check 2");

      final imageTemporary = File(image.path);

      _isUploadingImage = true; // Set uploading to true
      notifyListeners();
      print("here check 4");

      // Upload image to Firebase Storage
      final ref = FirebaseStorage.instance
          .ref()
          .child('News_Image/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(imageTemporary);

      // Get the download URL of the uploaded image
      final urlDownload = await ref.getDownloadURL();

      // Update user profile image URL in Firestore
      await _updateUserProfileImage(urlDownload);

      _isUploadingImage =
          false; // Set uploading to false when upload is complete
      notifyListeners();

      print('Image uploaded successfully');
    } on PlatformException catch (e) {
      print('Error picking image: $e');
    }
  }

  Future<void> _updateUserProfileImage(String imageUrl) async {
    if (loginEmail != null) {
      print("here check 6");
      var querySnapshot = await FirebaseFirestore.instance
          .collection('UserSignUpData')
          .where('EmailAdress', isEqualTo: loginEmail)
          .get();
      print("login email check:$loginEmail");

      if (querySnapshot.docs.isNotEmpty) {
        var docId = querySnapshot.docs.first.id;
        await FirebaseFirestore.instance
            .collection('UserSignUpData')
            .doc(docId)
            .update({'image': imageUrl});
      }
    }
  }

  String? imageurl;
  Future<DocumentSnapshot?> fetchUserProfileImage() async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('UserSignUpData')
          .where('EmailAdress', isEqualTo: loginEmail)
          .get()
          .then((snapshot) => snapshot.docs.first);
      print("image url: ${userDoc['image']}");
      return userDoc;
    } catch (e) {
      print('Error fetching user image: $e');
      return null;
    }
  }

//update password
  Future<void> updatePassword(String password, BuildContext context) async {
    if (loginEmail != null) {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('UserSignUpData')
          .where('EmailAdress', isEqualTo: loginEmail)
          .get();
      if (querySnapshot.docs.isNotEmpty) {
        var docId = querySnapshot.docs.first.id;
        await FirebaseFirestore.instance
            .collection('UserSignUpData')
            .doc(docId)
            .update({'Password': password}).then((value) async {
          showSnackBar(
              context, "Password updated sucessfully.", SnackBarType.success);
          final pref = await SharedPreferences.getInstance();

          pref.setString("LoginPass", password);
          loginPass = password;
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Profile(),
            ),
          );
        });
      }
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

//get news api model
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

  //Tags method
  Future<NewsModel> getNewsByCategory(String category) async {
    final response = await http.get(Uri.parse(
        'https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=8a5ec37e26f845dcb4c2b78463734448'));
    var jsonData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return NewsModel.fromJson(jsonData);
    } else {
      throw Exception('Failed to load news');
    }
  }
  //text to speech
  final FlutterTts flutterTts = FlutterTts();
  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1); //range 0.5-1.5
    await flutterTts.speak(text);
  }

  //duration to speak
  double calculateSpeakingTime(String text, {int wordsPerMinute = 150}) {
    final wordCount = text.split(' ').length;
    final wordsPerSecond = wordsPerMinute / 60.0;
    return wordCount / wordsPerSecond;
  }

//Upload news data
// Dropdown items
  String? selectedItem;

  List<String> items = [
    'Sports',
    'Technology',
    'Entertainment',
  ];
//get user id

  void newsUploadToFirebase(
      BuildContext context, String? userIdA, List imageslist) async {
    if (userIdA == null) {
      // User is not signed in, display an error message or redirect to sign-in page
      showSnackBar(context, "Sign In Failed, Please Sign in to upload news",
          SnackBarType.fail);

      return; // Exit the function if user is not signed in
    }
    if (userIdA != null) {
      debugPrint("User ID in news upload method : ${userIdA}");
      CollectionReference _information =
          FirebaseFirestore.instance.collection('NewsUploadData');
      final String documentId2 = userIdA.toString();
      print("id here: $documentId2");
      try {
        DocumentSnapshot snapshot = await _information.doc(documentId2).get();
        if (snapshot.exists) {
          Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
          print("data here: $data");
          List<Map<String, dynamic>> NewsDataList = [];
          for (int i = 0; i < data['NewsData'].length; i++) {
            NewsDataList.add(data['NewsData'][i]);
          }
          print("user id here 2: $userIdA");
          NewsDataList.add({
            "description": decriptionController.text,
            "image path": imageslist,
            "tag": selectedItem?.toString() ?? "no tag",
            "title": titleController.text,
            "uploaderId": userIdA,
          });

          print('after add 2 the ${NewsDataList}');
          FirebaseFirestore.instance
              .collection('NewsUploadData')
              .doc(documentId2)
              .update({
            'NewsData': NewsDataList,
          });
          showSnackBar(
              context, "News Uploaded Successfully", SnackBarType.success);

          titleController.clear();
          decriptionController.clear();
          image = null;
          selectedItem = null;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => NewsUploaded(),
            ),
          );
        } else {
          print("Document doesn't exist");
        }
      } catch (e) {
        print(e);
      }
    }
  }

// Define urlDownload variable as a class-level variable
  String? urlDownload;

// Set the urlDownload value using this function
  void setPicture(String value) {
    urlDownload = value;
    notifyListeners();
  }

  void setimage(File value) {
    image = value;
    notifyListeners();
  }

  UploadTask? uploadTask;
  File? image;

  bool _isUploadingImage = false;
  bool get isUploadingImage => _isUploadingImage;

  Future<dynamic> pickImage(BuildContext context) async {
    try {
      ImageCache().clear();
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemporary = File(image.path);
      setimage(imageTemporary);

      final path = 'News_Image/${image.name}';
      final file = File(image.path);

      final ref = FirebaseStorage.instance.ref().child(path);
      uploadTask = ref.putFile(file);

      _isUploadingImage = true; // Set uploading to true
      notifyListeners();

      final snapshot = await uploadTask!.whenComplete(() {
        _isUploadingImage =
            false; // Set uploading to false when upload is complete
        notifyListeners();
      });

      final urlDownload = await snapshot.ref.getDownloadURL();

      setPicture(urlDownload);

      print('Download Link: $urlDownload');
    } on PlatformException catch (e) {
      Utils().toastMessage(e.toString());
    }
  }

//snack bar
  void showSnackBar(
      BuildContext context, String title, SnackBarType snackBarType) {
    IconSnackBar.show(context,
        snackBarType: snackBarType,
        snackBarStyle: const SnackBarStyle(
          maxLines: 2,
        ),
        label: title);
  }

//for forget password: SIMPLE SIGNIN
  validateForm(BuildContext context) async {
    FocusManager.instance.primaryFocus!.unfocus();
    final valid = forgetFormKey.currentState!.validate();
    if (!valid) {
      return;
    }
    forgetFormKey.currentState!.save();
    // loading(true);
    bool value = await makeResetPassword(newPassForgetController.text, context);
    if (value == false) {
      // loading(false);
      return;
    }
    Navigator.pop(context);
    showSnackBar(
        context,
        "Successfully Send Link, Please Check Your Email and Update Password",
        SnackBarType.success);

    // loading(false);
  }

  Future<bool> makeResetPassword(String email, BuildContext context) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, "Error in Password Reset: $e", SnackBarType.alert);
      return false;
    }
  }

//forget password: SIGN IN AMDIN
  void forgetPasswordAdmin(BuildContext context) async {
    CollectionReference _information =
        FirebaseFirestore.instance.collection('SignUpAdminData');

    // Query documents where PhoneNumber matches the provided value
    QuerySnapshot querySnapshot = await _information
        .where("PhoneNumber",
            isEqualTo: PhoneNumberForgetPassPhoneNumberController.text)
        .get();

    // Iterate through the documents and update the matching documents
    querySnapshot.docs.forEach((doc) async {
      // Update the document with the new PhoneNumber and Password
      await doc.reference.update({
        "PhoneNumber": PhoneNumberForgetPassPhoneNumberController.text,
        "Password": PassForgetPassPhoneNumberController.text,
      }).then((value) {
        showSnackBar(context, "Password update", SnackBarType.success);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => SigninAdminitrator()));
      }).onError((error, stackTrace) {
        showSnackBar(context, "Password update Failed", SnackBarType.fail);
      });
    });
  }

  //simple login
  final formkey = GlobalKey<FormState>();
  final passwordController = new TextEditingController();
  //set simple sign in 2nd time
  void signinUser(BuildContext context) async {
    try {
      setloading(true);
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection("UserSignUpData")
          .where('EmailAdress', isEqualTo: emailController.text)
          .where('Password',
              isEqualTo: passwordController
                  .text) // Assuming the field name for the password is 'Password'
          .get();
      print("inside....");
      if (querySnapshot.docs.isNotEmpty) {
        String userId = querySnapshot.docs[0].get('userId');
        userIDSignin = userId;

        debugPrint("User ID while sign in: ${userIDSignin}");
        final pref = await SharedPreferences.getInstance();
        pref.setString("LoginEmail", emailController.text.toString());
        pref.setString("LoginPass", passwordController.text.toString());
        showSnackBar(context, "Sign In Success", SnackBarType.success);
        //clear values of text feilds when move to next
        emailController.clear();
        passwordController.clear();
        setloading(false);
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
      } else {
        // User not found or password incorrect
        showSnackBar(context, "Sign In Failed", SnackBarType.fail);
        setloading(false);
      }
    } catch (e) {
      // Error occurred
      showSnackBar(context, "Sign In Failed", SnackBarType.fail);
    }
  }

  

//get login data from shared pref
  String? loginEmail, loginPass, loginUserName;
  void getSharedPref() async {
    final pref = await SharedPreferences.getInstance();
    loginEmail = pref.getString("LoginEmail");
    print("login email value in sp:${loginEmail}");
    loginPass = pref.getString("LoginPass");
    print("login pass value in sp:${loginPass}");
    loginUserName = pref.getString("LoginName");
    print("login name value in sp:${loginUserName}");
  }

//data upload to dahbord-> new uploaded data
  Future<List<dynamic>> getCollectionData() async {
    try {
      // Reference to the collection
      CollectionReference collectionRef =
          FirebaseFirestore.instance.collection('NewsUploadData');
      // Get documents in the collection
      QuerySnapshot querySnapshot = await collectionRef.get();
      List<dynamic> allNewsData = [];

      // Loop through documents
      querySnapshot.docs.forEach((doc) {
        // Access document data
        var data = doc.data() as Map<String, dynamic>;
        List<dynamic> newsDataList = data['NewsData'];
        allNewsData.addAll(newsDataList);
      });

      return allNewsData;
    } catch (e) {
      print('Error: $e');
      return [];
    }
  }

// Python file integration
  Future<void> showLips(String text) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/show_lips'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': text,
      }),
    );

    if (response.statusCode == 200) {
      print('Showing lips');
    } else {
      throw Exception('Failed to show lips');
    }
  }

  Future<void> updateAudio(String text) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:5000/update_audio'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'text': text,
      }),
    );

    if (response.statusCode == 200) {
      print('Audio updated');
    } else {
      throw Exception('Failed to update audio');
    }
  }

  // // //creating video of images
  Future<void> convertImageToVideo(BuildContext context) async {
    const String BASE_PATH = 'lib/assets/images/lip-sync Images/';
    const String OUTPUT_PATH = BASE_PATH + 'OUTPUT.mp4';
    if (await Permission.storage.request().isGranted) {
      String commandToExecute = '-framerate 2'
          '-i ${BASE_PATH} -s 1080X1620 -y ${OUTPUT_PATH}';
      await FFmpegKit.execute(commandToExecute).then((session) async {
        final returnCode = await session.getReturnCode();
        if (ReturnCode.isSuccess(returnCode)) {
          print('Video is successfully created');
          showSnackBar(
              context, 'Video is created successfully', SnackBarType.success);
        } else if (ReturnCode.isCancel(returnCode)) {
          print('Video is cancel');
        } else {}
      });
    } else if (await Permission.storage.isPermanentlyDenied) {
      print('Permission Denied');
    }
  }
}
