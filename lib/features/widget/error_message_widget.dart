import 'package:flutter/material.dart';

class ErrorMessageWidget extends StatelessWidget {
  final String message;
  final Key textKey;

  const ErrorMessageWidget({required this.textKey, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message,
        style: const TextStyle(fontSize: 20),
        key: textKey,
      ),
    );
  }
}
