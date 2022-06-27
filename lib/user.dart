import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({Key? key}) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(user!.email!),
      Container(
        alignment: Alignment.bottomCenter,
        child: ElevatedButton.icon(
          onPressed: () => {FirebaseAuth.instance.signOut()},
          icon: Icon(
            Icons.arrow_back,
            size: 32,
          ),
          label: Text(
            'Sign Out',
            style: TextStyle(fontSize: 24),
          ),
        ),
      )
    ]);
  }
}
