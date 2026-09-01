import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/login/widgets/custom_button.dart';
import 'package:flutter_application_4/login/widgets/customtextfield_widget.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final emailcontroller = TextEditingController();
  bool loading = false;

  Future resetpassword() async{
    setState(() {
      loading = true;
    });

    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(email: emailcontroller.text.trim());
      if(!mounted) return;
      setState(() {
        loading = false;
      });
      showMessage("Password reset email sent successfully");
      Navigator.pop(context);


    }on FirebaseAuthException catch(e){
      if(!mounted) return;
      setState(() {
        loading = false;
      });
      showMessage(e.message ?? "Something went wrong");
    }
    
  }


  void showMessage(String message){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password Page"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            CustomtextfieldWidget(
              controller: emailcontroller, 
              text: "Enter your email", 
              icon: Icons.mail
            ),
            SizedBox(height: 20,),
            CustomButton(
              onpressed: resetpassword,
              text: "Reset Password", 
              loading: loading
            )
          ],
        ),
      ),
    );
  }
}