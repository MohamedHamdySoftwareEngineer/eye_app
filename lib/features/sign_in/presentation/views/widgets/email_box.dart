import 'package:flutter/material.dart';
import 'package:eye/constants.dart';
import 'package:eye/core/utils/styles.dart';

class EmailBox extends StatefulWidget {
  const EmailBox({
    super.key,
    required this.text,
    this.controller,
  });
  final String text;
  final TextEditingController? controller;

  @override
  EmailBoxState createState() => EmailBoxState();
}

class EmailBoxState extends State<EmailBox> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    // Use the provided controller if available, otherwise create a new one.
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    // Dispose only if the controller was created locally.
    if (widget.controller == null) {
      _controller.dispose();
    }
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
          border: InputBorder.none,
          isDense: true,
        ),
        style: Styles.signTextStyle,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
