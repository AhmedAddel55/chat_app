import 'package:flutter/material.dart';
import 'package:scholar_chat/models/message.dart';
import 'package:scholar_chat/widgets/chat_bubule.dart';
import 'package:scholar_chat/widgets/constants.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  // ignore: unused_field
  final _controller = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessages);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt, descending: true).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          // ignore: unused_local_variable
          List<Message> messagesList = [];
          // ignore: dead_code
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            QueryDocumentSnapshot document = snapshot.data!.docs[i];

            // Access the data within the document and convert it to a Message object
            Message message =
                Message.fromJson(document.data() as Map<String, dynamic>);
            messagesList.add(message);
          }
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              backgroundColor: kPrimaryColor,
              title:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Image.asset(
                  kLogo,
                  height: 60,
                ),
                const Text('Chat')
              ]),
            ),
            // ignore: avoid_unnecessary_containers
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      reverse: true,
                      controller: _controller,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBubule(
                                message: messagesList[index],
                              )
                            : ChatBubuleForFrined(message: messagesList[index]);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (data) {
                      messages.add({
                        kTextMessage: data,
                        kCreatedAt: DateTime.now(),
                        'id': email,
                      });
                      controller.clear();
                      _controller.animateTo(
                        0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 500),
                      );
                    },
                    decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.send,
                        color: kPrimaryColor,
                      ),
                      hintText: 'Send your Message',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(
                            color: kPrimaryColor,
                          )),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Text('Loding');
        }
      },
    );
  }
}
