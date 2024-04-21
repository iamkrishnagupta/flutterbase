import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterbase/Components/ui_components.dart';

class SendData extends StatefulWidget {
  const SendData({super.key});

  @override
  State<SendData> createState() => _SendDataState();
}

class _SendDataState extends State<SendData> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  addData(String title, String desc) async {
    if (title.isEmpty || desc.isEmpty) {
      log('Enter all details');
    } else {
      FirebaseFirestore.instance.collection('Users').doc(title).set(
        {
          "title": title,
          "description": desc,
        },
      ).then(
        (value) => log('Data inserted.'),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Send Data'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Components.customTextField(
                titleController,
                'Enter Title',
                Icons.title,
                false,
              ),
              const SizedBox(height: 10),
              Components.customTextField(
                descController,
                'Enter Description',
                Icons.description_rounded,
                false,
              ),
              const SizedBox(height: 10),
              Components.customButton(() {
                addData(titleController.text, descController.text);
              }, 'Send Data')
            ],
          ),
        ),
      ),
    );
  }
}
