import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget {
  final String title;
  final String subTitle;
  const MyListTile({super.key, required this.title, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, bottom: 10),
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          subTitle,
          style: TextStyle(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
}
