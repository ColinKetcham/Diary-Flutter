import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stack/main.dart';
import 'utils.dart';

class MyLogin extends StatefulWidget {
  final VoidCallback onClickedSighnUp;

  const MyLogin({
    Key? key,
    required this.onClickedSighnUp,
  }) : super(key: key);

  @override
  State<MyLogin> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: 40),
        TextField(
          controller: emailController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: 'Email'),
          obscureText: false,
        ),
        SizedBox(height: 40),
        TextField(
          controller: passwordController,
          cursorColor: Colors.white,
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(labelText: 'Password'),
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
            'Sign In',
            style: TextStyle(fontSize: 24),
          ),
          onPressed: signIn,
        ),
        SizedBox(
          height: 24,
        ),
        RichText(
            text: TextSpan(
          style: TextStyle(color: Color.fromARGB(255, 0, 0, 0), fontSize: 20),
          text: 'No account? ',
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
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
