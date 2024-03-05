import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class SbubbleChat extends StatelessWidget {
  const SbubbleChat(
      {super.key, required this.storedMassege, required this.sender});
  final String storedMassege;
  final String sender;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
          margin: const EdgeInsets.fromLTRB(16, 8, 45, 8),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: const BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(15),
              topLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(sender,
                  style: const TextStyle(
                      color: Color(0xff2C2C2C),
                      fontWeight: FontWeight.w700,
                      fontSize: 13)),
              Text(storedMassege,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      //fontWeight: FontWeight.w500,
                      fontFamily: 'assets/fonts/Roboto-Bold.ttf')),
            ],
          )),
    );
  }
}

class RbubbleChat extends StatelessWidget {
  const RbubbleChat(
      {super.key, required this.storedMassege, required this.sender});
  final String storedMassege;
  final String sender;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.fromLTRB(45, 8, 16, 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sender,
                style: const TextStyle(
                    color: Color(0xff2C2C2C),
                    fontWeight: FontWeight.w700,
                    fontSize: 13)),
            Text(
              storedMassege,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontFamily: 'assets/fonts/NotoSans-VariableFont_wdth,wght.ttf',
                //fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
