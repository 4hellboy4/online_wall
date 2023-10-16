import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall_online/widgets/comment_button/comment_button.dart';
import 'package:wall_online/widgets/like_button/like_button.dart';

class WallPostMsg extends StatefulWidget {
  final String msg;
  final String user;
  final String postId;
  final List<String> likes;
  const WallPostMsg({
    Key? key,
    required this.msg,
    required this.user,
    required this.postId,
    required this.likes,
  }) : super(key: key);

  @override
  State<WallPostMsg> createState() => _WallPostMsgState();
}

class _WallPostMsgState extends State<WallPostMsg> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false; //TODO: look closer
  final TextEditingController _comment = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection("UserPosts").doc(widget.postId);

    if (isLiked) {
      postRef.update({
        "likes": FieldValue.arrayUnion([currentUser.email]),
      });
    } else {
      postRef.update({
        "likes": FieldValue.arrayRemove([currentUser.email]),
      });
    }
  }

  void postComment(String text) {
    FirebaseFirestore.instance
        .collection("UserPosts")
        .doc(widget.postId)
        .collection("Comments")
        .add({
      "CommentText": text,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now(),
    });
  }

  void commentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Add comment',
          style: TextStyle(color: Colors.white),
        ),
        content: TextField(
          controller: _comment,
          autofocus: true,
          style: const TextStyle(color: Colors.white),
          decoration: const InputDecoration(
            hintText: "Write a comment...",
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _comment.clear();
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.white),
            ),
          ),
          TextButton(
            onPressed: () {
              postComment(_comment.text);
              Navigator.pop(context);
              _comment.clear();
            },
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.user,
            style: TextStyle(
              color: Colors.grey[500],
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.msg,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  LikeButton(
                    isLiked: isLiked,
                    onTap: toggleLike,
                  ),
                  const SizedBox(height: 5),
                  Text(widget.likes.length.toString()),
                ],
              ),
              const SizedBox(width: 20),
              Column(
                children: [
                  CommentButton(
                    onTap: commentDialog,
                  ),
                  const SizedBox(height: 5),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection("UserPosts")
                        .doc(widget.postId)
                        .collection("Comments")
                        .snapshots(),
                    builder: (context, snap) {
                      return Center();
                    },
                  )
                ],
              ),
            ],
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
