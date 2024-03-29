import 'package:flutter/material.dart';
import 'package:sample2/components/text_field_container.dart';
import 'package:sample2/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String? hintText;
  final IconData icon;
  final ValueChanged<String>? onChanged;
  final String? Function(String? val)? validator;
  const RoundedInputField({
    Key? key,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
