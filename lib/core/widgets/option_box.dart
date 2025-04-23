// Enhanced OptionBox widget
import 'package:flutter/material.dart';
import 'package:eye/constants.dart';
import 'package:eye/core/utils/styles.dart';

class OptionBox extends StatefulWidget {
  const OptionBox({
    super.key, 
    required this.text, 
    this.height = 60, 
    this.percOfWidth = 0.45, 
    this.onTap, 
    this.icon,
    this.color,
  });
  
  final String text;
  final double percOfWidth;
  final double height;
  final VoidCallback? onTap;
  final IconData? icon;
  final Color? color;

  @override
  State<OptionBox> createState() => _OptionBoxState();
}

class _OptionBoxState extends State<OptionBox> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width * widget.percOfWidth;
    Color containerColor = widget.color ?? Colors.white;
    Color borderColor = widget.color?.withOpacity(0.5) ?? const Color(0xFFB28B67).withOpacity(0.5);
    
    return GestureDetector(
      onTapDown: (_) {
        setState(() {
          _isPressed = true;
        });
        _controller.forward();
      },
      onTapUp: (_) {
        setState(() {
          _isPressed = false;
        });
        _controller.reverse();
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      onTapCancel: () {
        setState(() {
          _isPressed = false;
        });
        _controller.reverse();
      },
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: screenWidth,
          height: widget.height,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: borderColor, width: 1.5),
            boxShadow: _isPressed 
                ? [] 
                : [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(
                  widget.icon,
                  color: Styles.brownWithoutShadow18.color,
                  size: 22,
                ),
                const SizedBox(width: 10),
              ],
              Text(
                widget.text,
                style: Styles.brownWithoutShadow18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}