import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:stack/login.dart';
import 'package:stack/signup.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context) => isLogin
      ? MyLogin(onClickedSighnUp: toggle)
      : SignUpWidget(onClickedSighnUp: toggle);

  void toggle() => setState(() => isLogin = !isLogin);
}
