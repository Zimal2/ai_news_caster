import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';

class Gemini extends StatefulWidget {
  const Gemini({super.key});

  @override
  State<Gemini> createState() => _GeminiState();
}

class _GeminiState extends State<Gemini> {
  static const apiKey = "AIzaSyApI2seQi8d2cv-WoF9evYDKebJ9Gq94F8";
  TextEditingController _geminiTextController = TextEditingController();
  final model = GenerativeModel(model: 'gemini-pro', apiKey: apiKey);
  final List<Message> _message = [];

//method to send message
  Future<void> sendMessage() async {
    final message = _geminiTextController.text;
    _geminiTextController.clear();
    setState(() {
      _message
          .add(Message(date: DateTime.now(), isUser: true, message: message));
    });
    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    setState(() {
      _message.add(Message(
          date: DateTime.now(), isUser: false, message: response.text ?? ""));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color.fromARGB(255, 104, 103, 103),
      appBar: AppBar(title: Text("Gemini")),

      body: Column(
        children: [
          Expanded(
              child: ListView.builder(
            itemCount: _message.length,
            itemBuilder: (context, index) {
              final message = _message[index];
              return Messages(
                  date: DateFormat('HH:mm').format(message.date),
                  isUser: message.isUser,
                  message: message.message);
            },
          ))
        ],
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
                        borderRadius: BorderRadius.circular(50)),
                    // focusedBorder: border,
                    // disabledBorder: border,
                    // enabledBorder: border,
                    suffixIcon: IconButton(
                        onPressed: () async {
                          sendMessage();
                          // await bloc
                          //     .getAiResponse(controller.text, context)
                          //     .then((value) {
                          //   controller.text = '';
                          // });
                        },
                        icon: const Icon(Icons.send))),
              ),
            ),
          ),
          // InkWell(
          //     onTapDown: (value) async {
          //       var available = await speech.initialize();
          //       if (available) {
          //         speech.listen(
          //           onResult: (result) {
          //             setState(() {
          //               controller.text = result.recognizedWords;
          //               debugPrint('stda ${result.recognizedWords}');
          //             });
          //           },
          //         );
          //       }
          //     },
          //     onTapUp: (details) {
          //       setState(() {
          //         speech.stop();
          //       });
          //     },
          //     child: const Icon(
          //       Icons.mic,
          //       size: 30,
          //     ))
        ],
      ),
    );
  }
}

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;

  const Messages(
      {super.key,
      required this.date,
      required this.isUser,
      required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isUser ? 100 : 10,
        right: isUser ? 10 : 100,
      ),
      decoration: BoxDecoration(
          color: isUser
              ? const Color.fromARGB(255, 9, 48, 79)
              : Colors.grey.shade300,
          borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              bottomLeft: isUser ? const Radius.circular(10) : Radius.zero,
              topRight: const Radius.circular(10),
              bottomRight: isUser ? Radius.zero : const Radius.circular(10))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            message,
            style: TextStyle(color: isUser ? Colors.white : Colors.black),
          ),
          Text(
            date,
            style: TextStyle(color: isUser ? Colors.white : Colors.black,fontSize: 10),
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
