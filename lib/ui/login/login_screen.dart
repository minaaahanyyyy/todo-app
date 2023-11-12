import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/ui/common/customFormField.dart';
import 'package:todo_app/validationUtils.dart';

import '../../FirebaseErrorCodes.dart';

class LoginScreen extends StatelessWidget {
  static const String routeName = 'login' ;
   LoginScreen({super.key});

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
        image: AssetImage("assets/images/SIGN IN – 1.png"),
        fit: BoxFit.fill
        )
      ),

        
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: EdgeInsets.all(20),

            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [





                  CustomFormField(
                    hint: ' Email ',
                    keyboardType: TextInputType.emailAddress,
                    validator: (text) {

                      if(text == null || text.trim().isEmpty){
                        return "Please Enter email";
                      }
                      if(!isValidEmail(text)){
                        return "invalid email";
                      }
                      return null;

                    },
                    controller: email,
                  ),

                  CustomFormField(
                    hint: ' Password ',
                    validator: (text){
                      if(text == null || text.isEmpty){
                        return "please enter your password";
                      }
                     if(password.text != text){
                       return "password doesn't match";
                     }
                      return null;
                    },
                    controller: password ,
                    keyboardType: TextInputType.text,
                    secureText: true,

                  ),

                  const SizedBox(
                    height:  25,
                  ),

                  ElevatedButton(onPressed: (){
                    login();
                  }, child: Text('Login'))
                ],
              ),
            ),
          ),

        )
    );
  }

  void login() async {
    if(formKey.currentState?.validate() == false){
      return;
    }
    try{
      var result = await FirebaseAuth.instance
          .signInWithEmailAndPassword
        (email: email.text
       , password: password.text);
      print(result.user?.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == FirebaseErrorCodes.userNotFound ||
          e.code == FirebaseErrorCodes.wrongPassword) {
          print('wrong email and password');
      }
    }
  }
}
