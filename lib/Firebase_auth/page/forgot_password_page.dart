



import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        'Reset Password',
        style: TextStyle(color: Colors.blue),
      ),
      backgroundColor: Colors.transparent,
    ),
    body: Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Receive an email to reset your password',
            style: TextStyle(fontSize: 24),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.black,
            decoration: InputDecoration(
                labelText: 'Email', labelStyle: TextStyle(fontSize: 30)),
            textInputAction: TextInputAction.done,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email) =>
            email != null && !EmailValidator.validate(email)
                ? 'Enter a valid Email'
                : null,
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton.icon(
              onPressed: resetPassword,
              icon: Icon(Icons.email_outlined),
              label: Text('Reset Password'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              )),
        ],
      ),
    ),
  );

  Future resetPassword() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    );

    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailController.text.trim());


    Navigator.of(context).popUntil((route) => route.isFirst);

    // Navigator.of(context).pop();
  }
}
