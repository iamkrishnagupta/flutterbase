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
              Components.customButton(() {}, 'Send Data')
            ],
          ),
        ),
      ),
    );
  }
}
