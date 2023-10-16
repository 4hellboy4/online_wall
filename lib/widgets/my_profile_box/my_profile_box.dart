import 'package:flutter/material.dart';

class MyProfileBox extends StatelessWidget {
  const MyProfileBox({
    Key? key,
    required this.labelName,
    required this.text,
    required this.onTap,
  }) : super(key: key);
  final String labelName;
  final String text;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Container(
        padding: const EdgeInsets.only(left: 15, bottom: 15),
        margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  labelName,
                  style: TextStyle(color: Colors.grey[500]),
                ),
                IconButton(
                  onPressed: onTap,
                  icon: const Icon(Icons.edit),
                  color: Colors.grey[600],
                ),
              ],
            ),
            Text(text),
          ],
        ),
      ),
    );
  }
}
