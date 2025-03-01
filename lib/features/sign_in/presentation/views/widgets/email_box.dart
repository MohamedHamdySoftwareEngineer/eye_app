import 'package:flutter/material.dart';
import 'package:eye/constants.dart';
import 'package:eye/core/utils/styles.dart';

class EmailBox extends StatefulWidget {
  const EmailBox({super.key, required this.text});
  final String text;

  @override
  _EmailBoxState createState() => _EmailBoxState();
}

class _EmailBoxState extends State<EmailBox> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(); // Initialize with the provided text
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      alignment: Alignment.centerLeft,
      width: 260,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: borderColor, width: 1),
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: Styles.signTextStyle,
          border: InputBorder.none, // No border around the TextField itself
          isDense: true, // Reduces padding inside the text field
          // Only show the asterisk when the field is empty
        ),
        style: Styles.signTextStyle,
        keyboardType: TextInputType.emailAddress, // Helps with email input
        textInputAction: TextInputAction.done, // Customize keyboard behavior
        
      ),
    );
  }
}