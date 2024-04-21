import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterbase/Components/ui_components.dart';
import 'package:image_picker/image_picker.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? pickedImage;

  // Function to display the image selection dialog
  void showAlertBox() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pick Image From'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
              ),
              ListTile(
                onTap: () {
                  pickImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to handle image picking
  Future<void> pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          pickedImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo C-Storage'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: showAlertBox,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      pickedImage != null ? FileImage(pickedImage!) : null,
                  child: pickedImage == null
                      ? const Icon(Icons.add_a_photo_rounded, size: 80)
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              Components.customTextField(
                emailController,
                "Email",
                Icons.mail,
                false,
              ),
              const SizedBox(height: 10),
              Components.customTextField(
                passwordController,
                "Password",
                Icons.password,
                true,
              ),
              const SizedBox(height: 20),
              Components.customButton(
                () {},
                'Sign Up',
              )
            ],
          ),
        ),
      ),
    );
  }
}
