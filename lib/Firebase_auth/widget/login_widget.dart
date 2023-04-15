






import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../page/forgot_password_page.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;

  const LoginWidget({Key? key,required this.onClickedSignUp}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
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
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            TextField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
              ),
            ),
            SizedBox(
              height: 4,
            ),
            TextField(
              controller: passwordController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  )),
              obscureText: true,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              onPressed: signIn,
              icon: Icon(Icons.lock_open, size: 32),
              label: Text(
                'Sign In',
              ),
            ),
            SizedBox(
              height: 24,
            ),
            GestureDetector(
              child: Text('Forgot Password',style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue,
                fontSize: 20,
              ),),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> ForgotPasswordPage()));
              },
            ),
            SizedBox(height: 16,),
            RichText(
              text:  TextSpan(
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  text: 'No Account?',
                  children: [
                    TextSpan(
                      recognizer: TapGestureRecognizer()..onTap = widget.onClickedSignUp,
                      text: 'SignUp',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 25,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    NavigatorKey.currentState!.popUntil((route) => route.isFirst);
    //Navigator.of(context).push(MaterialPageRoute(builder: (context)=>NotePage()));
  }
}
