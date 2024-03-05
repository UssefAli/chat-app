import 'package:chat_app/helpers/constants.dart';
import 'package:chat_app/models/massege.dart';
import 'package:chat_app/widgets/bubble_chat.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key, required this.email});
  static const String id = 'Chat page';
  final String email;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');
  TextEditingController controller = TextEditingController();
  var listController = ScrollController();
  late String myMessage;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy('createdAt', descending: true).snapshots(),
      builder: (context, snapshot) {
        List<Chat> chatList = [];
        if (snapshot.hasData) {
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            chatList.add(Chat.fromJson(snapshot.data!.docs[i]));
          }
        }

        return Stack(
          children: [
            Image.asset(
              'assets/images/floral-whatsapp-chat-rmzlyx15fhausbaf.jpg',
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fill,
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              appBar: AppBar(
                //automaticallyImplyLeading: false,
                shadowColor: Colors.black,
                backgroundColor: kPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 45,
                      height: 60,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                              'assets/images/_b71db9ac-0965-456a-b6c6-84cc349a441d-removebg.png'),
                          opacity: 1,
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 50),
                    ),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: listController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: chatList.length,
                      itemBuilder: (context, index) {
                        if (chatList[index].id == widget.email) {
                          return SbubbleChat(
                            storedMassege: chatList[index].massege,
                            sender: chatList[index].id,
                          );
                        } else {
                          return RbubbleChat(
                              storedMassege: chatList[index].massege,
                              sender: chatList[index].id);
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: controller,
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            autofocus: false,
                            onSubmitted: (value) {
                              if (controller.text.isNotEmpty) {
                                messages.add({
                                  'message': value,
                                  'createdAt': DateTime.now(),
                                  'id': widget.email,
                                });
                                listController.jumpTo(
                                  0,
                                );
                                controller.clear();
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            cursorColor: Colors.white,
                            decoration: const InputDecoration(
                              fillColor: kPrimaryColor,
                              filled: true,
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 15.0),
                                child: Icon(Icons.camera_alt),
                              ),
                              suffixIconColor: Colors.white54,
                              prefixIcon: Icon(Icons.emoji_emotions),
                              prefixIconColor: Colors.white54,
                              hintText: 'Message',
                              hintStyle: TextStyle(
                                color: Colors.white60,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(30),
                                  ),
                                  borderSide: BorderSide(
                                    color: kPrimaryColor,
                                  )),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(30),
                                ),
                                borderSide: BorderSide(color: kPrimaryColor),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 55,
                          height: 55,
                          margin: const EdgeInsets.only(left: 5),
                          decoration: BoxDecoration(
                            color: kPrimaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: IconButton(
                            onPressed: () {
                              if (controller.text.isNotEmpty) {
                                messages.add({
                                  'message': controller.text,
                                  'createdAt': DateTime.now(),
                                  'id': widget.email,
                                });
                                listController.jumpTo(
                                  0,
                                );
                                controller.clear();
                              }
                            },
                            icon: const Icon(Icons.send,
                                color: Colors.white, size: 27),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
