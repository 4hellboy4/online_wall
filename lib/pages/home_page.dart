import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wall_online/widgets/my_text_field/my_text_field.dart';
import 'package:wall_online/widgets/wall_post_msg/wall_post_msg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final TextEditingController _textController = TextEditingController();

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  void post() async {
    if (_textController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection("UserPosts").add({
        "name": currentUser.email,
        "msg": _textController.text,
        "time": Timestamp.now(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: const Text(
          "Home Page",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: signOut,
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("UserPosts")
                    .orderBy("TimeStamp", descending: false)
                    .snapshots(),
                builder: (context, snap) {
                  if (snap.hasData) {
                    return ListView.builder(
                      itemCount: snap.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snap.data!.docs[index];
                        return WallPostMsg(
                          msg: post["msg"],
                          user: post["name"],
                        );
                      },
                    );
                  } else if (snap.hasError) {
                    return Center(
                      child: Text("Error: ${snap.error}"),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: MyTextField(
                      controller: _textController,
                      hintText: "Write something",
                      obscureText: false,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_circle_up),
                  )
                ],
              ),
            ),
            Text(currentUser.email!),
          ],
        ),
      ),
    );
  }
}
