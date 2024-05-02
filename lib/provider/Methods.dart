import 'dart:convert';
import 'dart:io';
import 'package:ai_news_caster/modals/news_modals.dart';
import 'package:ai_news_caster/ui/dashboard/dashboard.dart';
import 'package:ai_news_caster/ui/mediaScreens/newsUploaded.dart';
import 'package:ai_news_caster/ui/phoneNumberconfirmed.dart';
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
  bool _isLoading = false;
  bool get loading => _isLoading;

  setloading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //methods

  //for signup admin
  void verify(BuildContext context) {
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
        // showAwesomeSnackbar(context, "Sign In Success",

        //     "Admin signed in successfully.", ContentType.success);
        showSnackBar(context, "Sign In Success", SnackBarType.success);
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) {
        //     return AlertDialog(
        //       title: Text("Sign In Success"),
        //       content: Text("Admin signed in successfully."),
        //       actions: [
        //         TextButton(
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //           child: Text("OK"),
        //         ),
        //       ],
        //     );
        //   },
        // );
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

  //text to speech
  final FlutterTts flutterTts = FlutterTts();
  speak(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1); //range 0.5-1.5
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
          Navigator.push(
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
  void login(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      try {
        setloading(true);
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: emailController.text.toString(),
          password: passwordController.text.toString(),
        );

        Utils().toastMessage(userCredential.user!.email!);

        final pref = await SharedPreferences.getInstance();
        print("LoginEmail: ${emailController.text.toString()}");
        print("Login password: ${passwordController.text.toString()}");

        pref.setString("LoginEmail", emailController.text.toString());
        pref.setString("LoginPass", passwordController.text.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      } catch (error) {
        setloading(false);
        String errorMessage = "Sign-in failed: ";
        if (error is FirebaseAuthException) {
          if (error.code == 'user-not-found') {
            errorMessage += 'No user found with this email.';
          } else if (error.code == 'wrong-password') {
            errorMessage += 'Wrong password provided for this user.';
          } else {
            errorMessage += error.message ?? "Unknown error";
          }
        } else {
          errorMessage += error.toString();
        }
        Utils().toastMessage(errorMessage);
      }
    }
  }

//get login data from shared pref
  String? loginEmail, loginPass;
  void getSharedPref() async {
    final pref = await SharedPreferences.getInstance();
    loginEmail = pref.getString("LoginEmail");
    print("login email value in sp:${loginEmail}");
    loginPass = pref.getString("LoginPass");
    print("login pass value in sp:${loginPass}");
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
    if(await Permission.storage.request().isGranted){
      String commandToExecute = 
      '-framerate 2'
      '-i ${BASE_PATH} -s 1080X1620 -y ${OUTPUT_PATH}';
      await FFmpegKit.execute(commandToExecute).then((session) async {
        final returnCode = await session.getReturnCode();
        if(ReturnCode.isSuccess(returnCode)){
          print('Video is successfully created');
          showSnackBar(context, 'Video is created successfully', SnackBarType.success);
        }
        else if(ReturnCode.isCancel(returnCode)){
          print('Video is cancel');
        }
        else{

        }
      });
    }
    else if(await Permission.storage.isPermanentlyDenied){
        print('Permission Denied');
      }
  }
}