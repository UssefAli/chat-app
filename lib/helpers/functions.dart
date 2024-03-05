import 'package:flutter/material.dart';

import 'constants.dart';

void showSnackBar(BuildContext context, {required String print}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(print),
    ),
  );
}

void custmoAlert(BuildContext context) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Error')]),
      content: const Text(
        'you have enterd invalid data',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
      backgroundColor: Colors.white,
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text(
            'ok',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
            ),
          ),
        ),
      ],
    ),
  );
}
