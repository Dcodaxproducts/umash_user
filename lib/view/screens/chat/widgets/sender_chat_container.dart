import 'package:flutter/material.dart';
import 'package:umash_user/common/network_image.dart';

class SenderChatContainer extends StatelessWidget {
  final String text;
  final String time;
  final String? imageurl;
  const SenderChatContainer(
      {super.key, required this.text, required this.time, this.imageurl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const SizedBox(
            width: 10,
          ),

          /// message
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(235, 190, 190, 1),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
              Text(
                text,
              ),
              Text(time,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.w400)),
            ]),
          ),
          const SizedBox(
            width: 5,
          ),

          /// image
          CircleAvatar(
            radius: 20,
            child: imageurl != null
                ? CustomNetworkImage(
                    url: imageurl,
                  )
                : Image.asset("assets/images/person.png"),
          ),
        ],
      ),
    );
  }
}
