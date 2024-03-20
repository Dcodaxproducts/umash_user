import 'dart:io';
import 'package:flutter/material.dart';
import 'package:umash_user/common/buttons.dart';

class ViewImage extends StatelessWidget {
  final String image;
  const ViewImage({required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          width: double.infinity,
          child: Hero(
            tag: image,
            child: InteractiveViewer(
              clipBehavior: Clip.none,
              panEnabled: true,
              child: Image.file(
                File(image),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
