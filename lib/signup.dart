import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stack/main.dart';

import 'form.dart';
import 'utils.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSighnUp;

  const SignUpWidget({
    Key? key,
    required this.onClickedSighnUp,
  }) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(height: 40),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: 'Email'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) =>
                email != null && !EmailValidator.validate(email)
                    ? 'Enter a valid email'
                    : null,
            obscureText: false,
          ),
          SizedBox(height: 40),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.white,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(labelText: 'Password'),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (password) => password != null && password.length < 6
                ? 'Password must have 6 characters'
                : null,
            obscureText: true,
          ),
          SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              minimumSize: Size.fromHeight(50),
            ),
            icon: Icon(
              Icons.lock_open,
              size: 32,
            ),
            label: Text(
              'Sign Up',
              style: TextStyle(fontSize: 24),
            ),
            onPressed: signUp,
          ),
          SizedBox(
            height: 24,
          ),
          RichText(
              text: TextSpan(
            style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
            text: 'Already have an account? ',
            children: [
              TextSpan(
                recognizer: TapGestureRecognizer()
                  ..onTap = widget.onClickedSighnUp,
                text: 'Sign Up',
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Theme.of(context).colorScheme.secondary),
              )
            ],
          ))
        ]),
      ),
    );
  }

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final userId = FirebaseAuth.instance.currentUser?.uid;
      await db.collection('users').add({'userId': userId});
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
