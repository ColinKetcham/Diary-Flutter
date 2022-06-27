import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseFirestore db = FirebaseFirestore.instance;

void addData() async {}

class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();
  final userId = FirebaseAuth.instance.currentUser!.uid;
  String dropDownValue = 'what';

  @override
  void dispose() {
    // TODO: implement dispose
    myController.dispose();
    super.dispose();
  }

  // getFriends() async {
  //   final data = await FirebaseFirestore.instance
  //       .collection('users')
  //       .where('userId', isEqualTo: userId)
  //       .snapshots();

  //   print(await data.first);
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            // The validator receives the text that the user has entered.
            controller: myController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
          ),
          // StreamBuilder(
          //   stream: FirebaseFirestore.instance
          //       .collection('users')
          //       .where('userId', isEqualTo: userId)
          //       .snapshots(),
          //   builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (!snapshot.hasData) {
          //       return Center(child: CircularProgressIndicator());
          //     }
          //     final data = snapshot.requireData.docs[0]['friends'];

          //     final List<String> friends =
          //         data.map((e) => e.toString()).toList();

          //     return DropdownButton(
          //       onChanged: (String? newValue) {
          //         setState(() {
          //           dropDownValue = newValue!;
          //         });
          //       },
          //       items: friends.map<DropdownMenuItem<String>>((String value) {
          //         return DropdownMenuItem<String>(
          //           value: value,
          //           child: Text(value),
          //         );
          //       }).toList(),
          //     );
          //   },
          // ),
          ElevatedButton(
            onPressed: () {
              // Validate returns true if the form is valid, or false otherwise.
              if (_formKey.currentState!.validate()) {
                // If the form is valid, display a snackbar. In the real world,
                // you'd often call a server or save the information in a database.
                final data = db
                    .collection("users")
                    .where('userId', isEqualTo: userId)
                    .get()
                    .then((res) {
                  final post = {
                    'post': myController.text,
                    'author': userId,
                    'hasAccess': res.docs[0]['friends'],
                  };

                  final newPost = db.collection('posts').add(post).then(
                      (DocumentReference doc) =>
                          print('DocumentSnapshot added with ID: ${doc.id}'));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('posted')),
                  );
                  myController.text = '';
                  FocusManager.instance.primaryFocus?.unfocus();
                });
              }
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
