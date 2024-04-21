import 'package:flutter/material.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phone Auth',
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          TextField(
            controller: phoneController,
            keyboardType: TextInputType.number,
            decoration:  InputDecoration(
              hintText: "Enter Phone Number",
              suffix: const Icon(Icons.phone,),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20);
              )
            ),
          ),
        ],
      ),
    );
  }
}
