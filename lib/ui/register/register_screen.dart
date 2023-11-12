import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/FirebaseErrorCodes.dart';
import 'package:todo_app/ui/common/customFormField.dart';
import 'package:todo_app/validationUtils.dart';

class RegisterScreen extends StatelessWidget {
  static const String routeName = 'register' ;
   RegisterScreen({super.key});
  TextEditingController fullName = TextEditingController();
  TextEditingController userName = TextEditingController();
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
                    hint: ' Full Name',
                    keyboardType: TextInputType.name,
                    validator: (text) {

                      if(text == null || text.trim().isEmpty){
                        return "Please Enter full name";
                      }
                      return null;

                    },
                    controller: fullName,

                  ),

                  CustomFormField(
                    hint: ' User Name',
                    validator: (text) {

                      if(text == null || text.trim().isEmpty){
                        return "Please Enter user name";
                      }
                      return null;

                    },
                    controller: userName,

                  ),

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

                  CustomFormField(
                    hint: ' Confirm Password ',
                    keyboardType: TextInputType.text,
                    secureText: true,
                    validator: (text){
                      if(text == null || text.isEmpty){
                        return "please enter your password";
                      }
                      if (text.length<6){
                        return 'password should at least 6 characters';
                      }
                      return null;
                    },
                    controller: confirmPassword,

                  ),

                  const SizedBox(
                    height:  25,
                  ),

                  ElevatedButton(onPressed: (){
                    creatAccount();
                  }, child: Text('Creat Account'))
                ],
              ),
            ),
          ),

        )
    );
  }

  void creatAccount ()async {
    if(formKey.currentState?.validate() == false){
      return;
    }
   try{
     var result = await FirebaseAuth.instance
         .createUserWithEmailAndPassword
       (email: email.text, password: password.text);
     print(result.user?.uid);
   } on FirebaseAuthException catch (e) {
     if (e.code == FirebaseErrorCodes.weakPassword) {
       print('The password provided is too weak.');
     } else if (e.code == FirebaseErrorCodes.emailInUse) {
       print('The account already exists for that email.');
     }
   } catch (e) {
     print(e);
   }
  }
}
