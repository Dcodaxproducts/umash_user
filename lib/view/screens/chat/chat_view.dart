import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:umash_user/utils/colors.dart';
import 'package:umash_user/utils/style.dart';
import 'package:umash_user/view/screens/chat/widgets/chat_bottom_field.dart';
import 'package:umash_user/view/screens/chat/widgets/chat_list.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(primaryColor)),
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 20,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Chat',
          style: Theme.of(context).textTheme.displaySmall,
        ),
        actions: [
          IconButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(primaryColor)),
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.phone,
              size: 20,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: pagePadding,
        child: const Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,
            children: [
              /// chat list
              Expanded(child: ChatList()),

              /// bottom
              ChatBottomField()
            ]),
      ),
    );
  }
}
