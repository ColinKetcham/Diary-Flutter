import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stack/form.dart';

class UserPostsWidget extends StatefulWidget {
  const UserPostsWidget({Key? key}) : super(key: key);

  @override
  State<UserPostsWidget> createState() => _UserPostsWidgetState();
}

class _UserPostsWidgetState extends State<UserPostsWidget> {
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('author', isEqualTo: userId)
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
