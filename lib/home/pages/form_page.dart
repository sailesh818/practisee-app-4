import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  const FormPage({super.key});

  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final titleController = TextEditingController();
  final authorController = TextEditingController();
  final descriptionController = TextEditingController();
  final poemController = TextEditingController();
  final imageController = TextEditingController();
  final videoController = TextEditingController();
  final categoryController = TextEditingController();
  final tagsController = TextEditingController();

  bool isloading = false;

  Future<void> uploadpoem() async {
    if(!_formKey.currentState!.validate()) return;
    setState(() {
      isloading = true;
    });

    try{
      await FirebaseFirestore.instance.collection("poems").add(
        {
          "name": nameController.text.trim(),
          "title": titleController.text.trim(),
          "author": authorController.text.trim(),
          "description": descriptionController.text.trim(),
          "poem": poemController.text.trim(),
          "image": imageController.text.trim(),
          "video": videoController.text.trim(),
          "category": categoryController.text.trim(),
          "tags": tagsController.text.trim(),
          "createdAt": FieldValue.serverTimestamp(),
        }
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Poem uploaded successfully"))
      );

      nameController.clear();
      titleController.clear();
      authorController.clear();
      descriptionController.clear();
      poemController.clear();
      imageController.clear();
      videoController.clear();
      categoryController.clear();
      tagsController.clear();

    } catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()))
      );
      
    }

    setState(() {
      isloading = false;
    });
  }




  
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}



