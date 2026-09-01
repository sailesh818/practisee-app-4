import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onpressed;
  final bool loading;

  const CustomButton({super.key, required this.text, this.onpressed, required this.loading});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: loading ? null : onpressed, 
        child: loading
        ? CircularProgressIndicator(
          color: Colors.blue,
        )
        : Text(text, style: TextStyle(fontSize: 15),)
      ),
    );
  }
}