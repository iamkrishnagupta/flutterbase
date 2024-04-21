import 'package:flutter/material.dart';
import 'package:flutterbase/Components/ui_components.dart';

class DemoPage extends StatefulWidget {
  const DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  showAlertBox() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          title: Text(
            'Pick Image From',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text('Gallery'),
              ),
            ],
          ),
        );
      },
    );
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
                onTap: () {
                  showAlertBox();
                },
                child: const CircleAvatar(
                  radius: 80,
                  child: Icon(Icons.add_a_photo_rounded, size: 80),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Components.customTextField(
                emailController,
                "Email",
                Icons.mail,
                false,
              ),
              const SizedBox(
                height: 10,
              ),
              Components.customTextField(
                passwordController,
                "Password",
                Icons.password,
                true,
              ),
              const SizedBox(
                height: 20,
              ),
              Components.customButton(() {}, 'Sign Up')
            ],
          ),
        ),
      ),
    );
  }
}
