import 'package:flutter/material.dart';
import 'package:umash_user/common/network_image.dart';

class ReceiverChatContainer extends StatelessWidget {
  final String text;
  final String time;
  final String? imageurl;

  const ReceiverChatContainer(
      {super.key, required this.text, required this.time, this.imageurl});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ///
          ///Image
          CircleAvatar(
            radius: 20,
            child: imageurl != null
                ? CustomNetworkImage(
                    url: imageurl,
                  )
                : Image.asset("assets/images/person.png"),
          ),
          const SizedBox(
            width: 10,
          ),

          /// message
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Color.fromRGBO(233, 252, 88, 0.3),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                text,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
              Text(time,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: const Color.fromRGBO(173, 181, 189, 1),
                      fontWeight: FontWeight.w400)),
            ]),
          )
        ],
      ),
    );
  }
}
