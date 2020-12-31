import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;

  final String validateText;

  final Icon icon;

  final bool readOnly;

  final ValueChanged<String> onChange;

  final TextInputType keyboardType;

  final String initialValue;

  CustomTextFormField(
      {this.labelText,
      this.validateText,
      this.icon,
      this.readOnly = false,
      this.onChange,
      this.keyboardType = TextInputType.text,
      this.initialValue});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      child: TextFormField(
        readOnly: readOnly,
        initialValue: initialValue,
        keyboardType: keyboardType,
        onChanged: onChange,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10, bottom: 10),
          isDense: true,
          labelText: labelText,
          prefixIcon: Padding(
            padding: EdgeInsets.only(top: 15),
            child: icon,
          ),
        ),
        validator: (value) {
          if (value.isEmpty) {
            return validateText;
          }
          return null;
        },
        inputFormatters: [
          keyboardType == TextInputType.number
              ? FilteringTextInputFormatter.allow(RegExp('[12345678]'))
              : FilteringTextInputFormatter.singleLineFormatter,
        ],
      ),
    );
  }
}
