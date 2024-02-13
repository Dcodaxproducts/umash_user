import 'package:flutter/material.dart';
import 'package:umash_user/utils/colors.dart';

class ChatBottomField extends StatelessWidget {
  const ChatBottomField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          flex: 9,
          child: TextFormField(
            decoration: InputDecoration(
              isDense: true,
              border: InputBorder.none,
              filled: true,
              fillColor: Theme.of(context).brightness == Brightness.light
                  ? Colors.grey.shade100
                  : Colors.grey.shade900,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              icon: const Icon(Icons.send, color: primaryColor),
              onPressed: () {},
            ),
          ),
        )
      ]),
    );
  }
}
