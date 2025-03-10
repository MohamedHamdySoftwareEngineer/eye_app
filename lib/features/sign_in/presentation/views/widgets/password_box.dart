import 'package:flutter/material.dart';
import 'package:eye/constants.dart';
import 'package:eye/core/utils/styles.dart';

class PasswordBox extends StatefulWidget {
  const PasswordBox({
    super.key,
    required this.text,
    this.controller,
  });

  final String text;
  final TextEditingController? controller;

  @override
  PasswordBoxState createState() => PasswordBoxState();
}

class PasswordBoxState extends State<PasswordBox> {
  late TextEditingController _controller;
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    // Use the provided controller if available, otherwise create a new one.
    _controller = widget.controller ?? TextEditingController();
  }

  @override
  void dispose() {
    // Dispose only if the controller was created inside the widget.
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
        textAlignVertical: TextAlignVertical.center,
        controller: _controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.text,
          hintStyle: Styles.signTextStyle,
          border: InputBorder.none,
          isDense: true,
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: signColor,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
        style: Styles.signTextStyle,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
