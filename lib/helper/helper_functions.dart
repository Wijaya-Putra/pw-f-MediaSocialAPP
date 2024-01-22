import 'package:flutter/material.dart';

// Error Message to user
void displayPopupMessage(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text(message),
          ));
}
