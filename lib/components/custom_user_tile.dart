// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:chatapp_with_firebase/extensions/extensions.dart';
import 'package:flutter/material.dart';

class CustomUserTile extends StatelessWidget {
  final String text;
  final void Function()? onTap;

  const CustomUserTile({super.key, required this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: context.color.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            //icon
            Icon(Icons.person),

            SizedBox(width: 20),

            // username
            Text(text),
          ],
        ),
      ),
    );
  }
}
