import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
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

  void signUp(String email, String password) async {
    if (email.isEmpty || password.isEmpty || pickedImage == null) {
      Components.customAlertBox(
          context, "Please fill all fields and select an image.");
      return;
    }
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      log('User registered: ${userCredential.user!.email}');
      uploadData();
    } on FirebaseAuthException catch (e) {
      log('Firebase Auth Error: ${e.message}');
      Components.customAlertBox(
          context, e.message ?? "An unknown error occurred with Firebase.");
    } catch (e) {
      log('General Error during signUp: $e');
      Components.customAlertBox(
          context, "An error occurred. Please try again.");
    }
  }

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
      log('Error picking image: $e');
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
                child: pickedImage != null
                    ? CircleAvatar(
                        radius: 80,
                        backgroundImage: FileImage(pickedImage!),
                      )
                    : const CircleAvatar(
                        radius: 80,
                        child: Icon(
                          Icons.person,
                          size: 80,
                        ),
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
                Icons.lock_outline,
                true,
              ),
              const SizedBox(height: 20),
              Components.customButton(
                () {
                  signUp(emailController.text, passwordController.text);
                },
                'Sign Up',
              )
            ],
          ),
        ),
      ),
    );
  }

   Future<void> uploadData() async {
  if (pickedImage == null) {
    log('No image selected or picked image is null.');
    return;
  }
  log('File to upload: ${pickedImage!.path}');
  try {
    String filePath = 'Profile Images/${emailController.text}';
    log('Firebase Storage Path: $filePath');

    UploadTask uploadTask = FirebaseStorage.instance
        .ref(filePath)
        .putFile(pickedImage!);
    log('Upload task started');

    // Listen to the upload task
    uploadTask.snapshotEvents.listen(
      (TaskSnapshot snapshot) {
        switch (snapshot.state) {
          case TaskState.running:
            final progress = 100.0 * (snapshot.bytesTransferred / snapshot.totalBytes);
            log('Upload is $progress% complete.');
            break;
          case TaskState.paused:
            log('Upload is paused.');
            break;
          case TaskState.success:
            log('Upload is successfully completed.');
            break;
          case TaskState.canceled:
            log('Upload is canceled.');
            break;
          case TaskState.error:
            log('Upload failed with an error.');
            break;
        }
      }, 
      onError: (e) {
        log('Upload failed with error: $e');
        Components.customAlertBox(context, "Upload failed: $e");
      }
    );

    // Await completion of the upload
    final taskSnapshot = await uploadTask;
    log('File uploaded to Firebase Storage');

    final url = await taskSnapshot.ref.getDownloadURL();
    log('Download URL obtained: $url');

    await FirebaseFirestore.instance
        .collection("Users")
        .doc(emailController.text)
        .set({
      "email": emailController.text,
      "image": url,
    });
    log('User data uploaded successfully to Firestore');
  } catch (e) {
    log('Error uploading user data: $e');
    Components.customAlertBox(
        context, "Failed to upload data: ${e.toString()}");
  }
}
}