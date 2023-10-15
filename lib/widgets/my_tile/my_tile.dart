import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  const MyTile(
      {Key? key, required this.icon, required this.text, required this.onTap})
      : super(key: key);
  final IconData icon;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0),
      child: ListTile(
        onTap: onTap,
        leading: Icon(
          icon,
          color: Colors.white,
        ),
        title: Text(
          text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
