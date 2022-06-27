import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stack/form.dart';

class FriendPosts extends StatefulWidget {
  const FriendPosts({Key? key}) : super(key: key);

  @override
  State<FriendPosts> createState() => _FriendPostsState();
}

class _FriendPostsState extends State<FriendPosts> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('hasAccess', arrayContains: userId)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((post) {
              return Center(
                child: ListTile(
                  title: Text(post['post']),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
