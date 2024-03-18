import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

class Gemini extends StatefulWidget {
  const Gemini({Key? key});

  @override
  State<Gemini> createState() => _GeminiState();
}

class _GeminiState extends State<Gemini> {
  static const apiKey = "AIzaSyApI2seQi8d2cv-WoF9evYDKebJ9Gq94F8";
  TextEditingController _geminiTextController = TextEditingController();
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  final List<Message> _message = [];
  bool _isFetchingResponse = false; // Added boolean variable

  // Method to send message
  Future<void> sendMessage() async {
    final message = _geminiTextController.text;
    _geminiTextController.clear();
    setState(() {
      _message.add(Message(date: DateTime.now(), isUser: true, message: message));
    });
    final content = [Content.text(message)];
    
    setState(() {
      _isFetchingResponse = true; // Set to true when fetching response
    });
    
    final response = await model.generateContent(content);
    setState(() {
      _isFetchingResponse = false; // Set to false after fetching response
      _message.add(Message(date: DateTime.now(), isUser: false, message: response.text ?? ""));
    });

    // Pass the response to the UploadNews screen
    Navigator.pop(context, response.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gemini")),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Center(
                  child: Text(
                    "Note: You can only enter one query",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.8,
              width: MediaQuery.of(context).size.width * 0.9,
              child: ListView.builder(
                itemCount: _message.length,
                itemBuilder: (context, index) {
                  final message = _message[index];
                  return Messages(
                    date: DateFormat('HH:mm').format(message.date),
                    isUser: message.isUser,
                    message: message.message,
                    isFetching: _isFetchingResponse,
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                      controller: _geminiTextController,
                      decoration: InputDecoration(
                        fillColor: Colors.black45,
                        filled: true,
                        hintText: "Enter your message",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () async {
                            sendMessage();
                          },
                          icon: Icon(Icons.send),
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  final bool isFetching;

  const Messages({
    Key? key,
    required this.date,
    required this.isUser,
    required this.message, required this.isFetching,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: EdgeInsets.symmetric(
        vertical: 15,
        horizontal: isUser ? 10 : 100,
      ),
      decoration: BoxDecoration(
        color: isUser ? Color.fromARGB(255, 9, 48, 79) : Colors.grey.shade300,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          bottomLeft: isUser ? Radius.circular(10) : Radius.zero,
          topRight: Radius.circular(10),
          bottomRight: isUser ? Radius.zero : Radius.circular(10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
          isFetching
           ? Center(child: CircularProgressIndicator())
           : Text(
            date,
            style: TextStyle(
              color: isUser ? Colors.white : Colors.black,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final bool isUser;
  final String message;
  final DateTime date;

  Message({
    required this.date,
    required this.isUser,
    required this.message,
  });
}
