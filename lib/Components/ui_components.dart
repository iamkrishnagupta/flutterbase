import 'package:flutter/material.dart';

class Components {
  static customTextField(TextEditingController controller, String hintText,
      IconData iconData, bool isHide) {
    return TextField(
      controller: controller,
      obscureText: isHide,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: Icon(iconData),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  static customButton(VoidCallback voidCallBack, String text) {
    return SizedBox(
      height: 50,
      width: 200,
      child: ElevatedButton(
        onPressed: () {
          voidCallBack();
        },
        child: Text(
          text,
          style: const TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
    );
  }
}
