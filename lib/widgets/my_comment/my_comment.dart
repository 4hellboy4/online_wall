import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyComment extends StatelessWidget {
  const MyComment({
    Key? key,
    required this.text,
    required this.user,
    required this.time,
    required this.postId,
    required this.commentIndex,
  }) : super(key: key);
  final String text;
  final String user;
  final String time;
  final String postId;
  final String commentIndex;

  void deleteComment() {
    try {
      FirebaseFirestore.instance
          .collection("UserPosts")
          .doc(postId)
          .collection("Comments")
          .doc(commentIndex)
          .delete();
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(5),
          ),
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.only(bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(text),
                  Row(
                    children: <Widget>[
                      Text(
                        user,
                        style: const TextStyle(color: Colors.grey),
                      ),
                      const Text(" * "),
                      Text(
                        time,
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
              IconButton(
                onPressed: deleteComment,
                icon: const Icon(
                  Icons.delete,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}
