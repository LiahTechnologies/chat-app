// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:njadia/src/core/chats%20functionality/pages/messages.dart';
import 'package:njadia/src/core/common/constants/style/color.dart';
import 'package:njadia/src/core/entities/message_entity.dart';
import 'package:njadia/src/features/direct%20message/data/model/message_model.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../model/chat_model.dart';
import '../core/style.dart';
import '../../utils/custom_popup_menu.dart';
import '../../utils/reply_card.dart';
import '../../utils/user_card.dart';

// import 'package:flutter/foundation.dart' as foundation;

class IndividualPage extends StatefulWidget {
  const IndividualPage({super.key, required this.chatModel});
  final ChatModel chatModel;
  @override
  State<IndividualPage> createState() => _IndividualPageState();
}

class _IndividualPageState extends State<IndividualPage> {
  final TextEditingController controller = TextEditingController();
  bool showEmoji = false;

  FocusNode focusNode = FocusNode();
  late List<MessageEntity> messages = [];
  late IO.Socket socket;

  final List<PopupMenuItem> items = [
    PopupMenuItem(
      child: Text("View Contact"),
      value: "View Contact",
    ),
    PopupMenuItem(
      child: Text("Media, link and docs"),
      value: "Media, link and docs",
    ),
    PopupMenuItem(
      child: Text("Whatsap web"),
      value: "Whatsapp web",
    ),
    PopupMenuItem(
      child: Text("Search"),
      value: "Search",
    ),
    PopupMenuItem(
      child: Text("Mute notifications"),
      value: "Mute notifications",
    ),
    PopupMenuItem(
      child: Text("Wallpaper"),
      value: "wallpaper",
    ),
  ];

  @override
  void initState() {
    connect();
    super.initState();

    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          showEmoji = false;
        });
      }
    });
  }

  void connect() {
    socket = IO.io("http://192.168.30.98:5000/", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    });
    socket.connect(); //connect the Socket.IO Client to the Server

    //SOCKET EVENTS
    // --> listening for connection
    socket.on('connect', (data) {
      print(socket.connected);
      print("USER SOCKET ID IS:${socket.id}");
    });

    //listen for incoming messages from the Server.

    //listens when the client is disconnected from the Server
    socket.on('disconnect', (data) {
      print('disconnect');
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // CHAT BACKGROUND IMAGE
        Image.asset(
          "",
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.cover,
        ),

        Scaffold(
          backgroundColor: Colors.blueGrey.shade400,
          appBar: AppBar(
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
            // centerTitle: true,
            leadingWidth: 70,
            titleSpacing: 1,
            leading: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: primaryWhite,
                    )),
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey.shade300,
                  child: Icon(
                    widget.chatModel.isGroup ? Icons.group : Icons.person,
                    size: 22,
                  ),
                )
              ],
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: EdgeInsets.only(right: 9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.name,
                      style: TextStyle(
                          color: primaryWhite,
                          fontWeight: FontWeight.normal,
                          fontSize: 20),
                    ),
                    Text(
                      "lastseen: 9:00am",
                      style: TextStyle(
                          color: primaryWhite.withOpacity(0.5), fontSize: 13),
                    )
                  ],
                ),
              ),
            ),

            actions: [
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.videocam,
                    color: primaryWhite,
                  )),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.call,
                    color: primaryWhite,
                  )),
              CustomPopUpMenu(items: items)
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
              onWillPop: () {
                if (showEmoji) {
                  setState(() {
                    showEmoji = false;
                  });
                } else {
                  Navigator.pop(context);
                }

                return Future.value(false);
              },
              child: Stack(
                children: [
                  Container(
                      height: MediaQuery.of(context).size.height - 144,
                      child: ListView.builder(
                          itemCount: messages.length,
                          itemBuilder: (context, index) => MessageList(
                                messageEntity: messages[index],
                              ))),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width - 60,
                                  child: Card(
                                      color: AppColor.darkIconColor,
                                      margin: EdgeInsets.only(
                                          left: 2, right: 2, bottom: 8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: TextFormField(
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium,
                                        controller: controller,
                                        onChanged: (v) {
                                          setState(() {
                                            controller.text = v;
                                          });
                                        },
                                        maxLines: 4,
                                        minLines: 1,
                                        keyboardType: TextInputType.multiline,
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            prefixIcon: IconButton(
                                              icon: Icon(Icons.emoji_emotions),
                                              onPressed: () {
                                                focusNode.unfocus();
                                                focusNode.canRequestFocus =
                                                    false;

                                                setState(() {
                                                  showEmoji = !showEmoji;
                                                });
                                              },
                                            ),
                                            suffixIcon: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      showModalBottomSheet(
                                                          backgroundColor:
                                                              Colors
                                                                  .transparent,
                                                          context: context,
                                                          builder: (context) =>
                                                              attarchCard());
                                                    },
                                                    icon: Icon(
                                                        Icons.attach_file)),
                                                IconButton(
                                                    onPressed: () {},
                                                    icon:
                                                        Icon(Icons.camera_alt))
                                              ],
                                            ),
                                            contentPadding: EdgeInsets.all(10),
                                            hintText: "Type a message",
                                            hintStyle: Theme.of(context)
                                                .textTheme
                                                .displayMedium),
                                      ))),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, right: 2),
                                child: CircleAvatar(
                                  radius: 25,
                                  child: IconButton(
                                    icon: Icon(
                                      controller.text.isEmpty
                                          ? Icons.mic
                                          : Icons.send,
                                      color: Theme.of(context).iconTheme.color,
                                    ),
                                    onPressed: () {
                                      socket.emit(
                                          'message',
                                                // "testing sockets"
                                              
                                         ( controller.text)
                                              
                                              );

                                      controller.clear();

                                      // socket.on('message', (data) {
                                      //   ;
                                      //   // print(" THSI IS JSON DECODED  $info");
                                      //   setState(() {
                                      //     messages.add(
                                      //         ChatMessageModel.fromjson(data));

                                      //     print(
                                      //         "the length is ${messages.length}");
                                      //   });
                                      //   //
                                      // });
                                    },
                                  ),
                                ),
                              )
                            ],
                          ),
                          // emojiWidget(controller),
                        ],
                      )),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget attarchCard() {
    return Container(
      height: 270,
      width: MediaQuery.of(context).size.width,
      child: Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      icon: Icons.insert_drive_file,
                      text: "Document",
                      color: Colors.indigo),
                  SizedBox(width: 20),
                  iconCreation(
                      icon: Icons.camera_alt,
                      text: "Camera",
                      color: Colors.pink),
                  SizedBox(width: 20),
                  iconCreation(
                      icon: Icons.insert_photo,
                      text: "Photo",
                      color: Colors.purple),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconCreation(
                      icon: Icons.headset, text: "Audio", color: Colors.orange),
                  SizedBox(width: 20),
                  iconCreation(
                      icon: Icons.location_pin,
                      text: "Location",
                      color: Colors.teal),
                  SizedBox(width: 20),
                  iconCreation(
                      icon: Icons.person, text: "Contact", color: Colors.blue),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget iconCreation(
      {required IconData icon, required String text, required Color color}) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: 30,
            child: Icon(
              icon,
              color: primaryWhite,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text("$text")
        ],
      ),
    );
  }

  // Widget emojiWidget(TextEditingController controller) {
  //   return Offstage(
  //     offstage: showEmoji,
  //     child: EmojiPicker(
  //       textEditingController: controller,
  //       // scrollController: _scrollController,
  //       config: Config(
  //         height: 256,
  //         checkPlatformCompatibility: true,
  //         emojiViewConfig: EmojiViewConfig(
  //           // Issue: https://github.com/flutter/flutter/issues/28894
  //           emojiSizeMax: 28 *
  //               (foundation.defaultTargetPlatform == TargetPlatform.iOS
  //                   ? 1.2
  //                   : 1.0),
  //         ),
  //         swapCategoryAndBottomBar: false,
  //         skinToneConfig: const SkinToneConfig(),
  //         categoryViewConfig: const CategoryViewConfig(),
  //         bottomActionBarConfig: const BottomActionBarConfig(),
  //         searchViewConfig: const SearchViewConfig(),
  //       ),
  //     ),
  //   );
  // }
}
