import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wall_online/widgets/like_button/like_button.dart';

class WallPostMsg extends StatefulWidget {
  final String msg;
  final String user;
  final String userId;
  final List<String> likes;
  const WallPostMsg({
    Key? key,
    required this.msg,
    required this.user,
    required this.userId,
    required this.likes,
  }) : super(key: key);

  @override
  State<WallPostMsg> createState() => _WallPostMsgState();
}

class _WallPostMsgState extends State<WallPostMsg> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef = FirebaseFirestore.instance.collection("UserPosts").doc(widget.userId);

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

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Column(
            children: <Widget>[
              LikeButton(
                isLiked: isLiked,
                onTap: toggleLike,
              ),
              const SizedBox(height: 5),
              Text(widget.likes.length.toString()),
              //like counter
            ],
          ),
          const SizedBox(width: 15),
          Column(
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
            ],
          ),
        ],
      ),
    );
  }
}
