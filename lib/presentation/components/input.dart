import 'package:flutter/material.dart';
import 'package:furious_red_dragon/core/constants.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final Function onChanged;
  final bool obscureText;
  final TextInputType keyboardType;

  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.onChanged,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(43, 10, 43, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromRGBO(255, 232, 232, 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        onChanged: widget.onChanged(),
        obscureText: widget.obscureText,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: kGlobalTextStyle.copyWith(
            color: const Color.fromRGBO(177, 170, 170, 1),
            fontSize: 18,
          ),
          border: InputBorder.none,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        style: kGlobalTextStyle.copyWith(
          color: const Color.fromARGB(255, 2, 2, 2),
          fontSize: 18,
        ),
        cursorColor: kFuriousRedColor,
      ),
    );
  }
}
