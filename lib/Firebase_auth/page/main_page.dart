





import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app_flutter/Firebase_auth/page/verify_page.dart';

import 'auth_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator());
            }
            else if (snapshot.hasError){
              return Center(child: Text('Something went wrong'));
            }
            else if(snapshot.hasData) {
              return VerifyEmailPage();
            }
            else {
              return AuthPage() ;
            }
          }
      ),
    );
  }
}
