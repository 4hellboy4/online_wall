import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall_online/widgets/comment_button/comment_button.dart';
import 'package:wall_online/widgets/like_button/like_button.dart';
import 'package:wall_online/widgets/my_comment/my_comment.dart';

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
  bool isLiked = false;
  final TextEditingController _comment = TextEditingController();
  bool isCommentOpened = false;

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  @override
  void dispose() {
    _comment.dispose();
    super.dispose();
  }

  void toggleComment() {
    setState(() {
      isCommentOpened = !isCommentOpened;
    });
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    DocumentReference postRef =
        FirebaseFirestore.instance.collection("UserPosts").doc(widget.postId);

    try {
      if (isLiked) {
        postRef.update({
          "likes": FieldValue.arrayUnion([currentUser.email]),
        });
      } else {
        postRef.update({
          "likes": FieldValue.arrayRemove([currentUser.email]),
        });
      }
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  void postComment(String text) {
    try {
      FirebaseFirestore.instance
          .collection("UserPosts")
          .doc(widget.postId)
          .collection("Comments")
          .add({
        "CommentText": text,
        "CommentedBy": currentUser.email,
        "CommentTime": Timestamp.now(),
      });
    } on FirebaseException catch (e) {
      print(e.code);
    }
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

  void deletePost() async {
    try {
      var _comments = await FirebaseFirestore.instance
          .collection("UserPosts")
          .doc(widget.postId)
          .collection("Comments")
          .get();
      for (var com in _comments.docs) {
        FirebaseFirestore.instance
            .collection("UserPosts")
            .doc(widget.postId)
            .collection("Comments")
            .doc(com.id)
            .delete();
      }
      FirebaseFirestore.instance
          .collection("UserPosts")
          .doc(widget.postId)
          .delete()
          .then((value) => print("deleted"))
          .catchError((error) => print("something went wrong"));
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _commentsStream = FirebaseFirestore.instance
        .collection("UserPosts")
        .doc(widget.postId)
        .collection("Comments")
        .snapshots();
    return Container(
      height: isCommentOpened ? 500 : 150,
      margin: const EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
              IconButton(onPressed: deletePost, icon: const Icon(Icons.delete)),
            ],
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
                    onTap: toggleComment,
                  ),
                  const SizedBox(height: 5),
                  StreamBuilder<QuerySnapshot>(
                    stream: _commentsStream,
                    builder: (context, snap) {
                      if (!snap.hasData) {
                        return const Text("0");
                      } else if (snap.hasError) {
                        // Handle the error
                        return const Text("0");
                      }
                      return Text(snap.data!.docs.length.toString());
                    },
                  ),
                ],
              ),
            ],
          ),
          if (isCommentOpened)
            StreamBuilder<QuerySnapshot>(
              stream: _commentsStream,
              builder: (context, snap) {
                if (snap.hasData) {
                  return Expanded(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            TextButton(
                              onPressed: commentDialog,
                              child: const Text("Post Comment"),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: ListView.builder(
                            itemCount: snap.data!.docs.length,
                            itemBuilder: (context, index) {
                              final comment = snap.data!.docs[index];
                              return MyComment(
                                text: comment["CommentText"],
                                user: comment["CommentedBy"],
                                time: "13:28",
                                commentIndex: comment.id,
                                postId: widget.postId,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (!snap.hasData) {
                  return const Center(
                    child: Text("something went wrong..."),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
        ],
      ),
    );
  }
}
