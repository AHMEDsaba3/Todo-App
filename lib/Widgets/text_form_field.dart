import 'dart:ffi';
import 'package:flutter/material.dart';

class TextFormWidget extends StatelessWidget {
  const TextFormWidget(
      {super.key,
        required this.Controller,
        required this.label,
        required this.keyboardType,
        required this.preIcon,
        this.sufIcon,
        this.ispassword=false,
        required this.validator,
        this.onChanged,
        this.onFieldSubmitted,
        this.suffixPressed,
        this.maxLine,
        this.ontap,
        this.Clickable=true,
        this.minLine});

  final TextEditingController Controller;
  final String label;
  final bool ispassword;
  final bool Clickable;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? onFieldSubmitted;
  final Function()? suffixPressed;
  final IconData preIcon;
  final IconData? sufIcon;
  final TextInputType? keyboardType;
  final int? maxLine;
  final int? minLine;
  final Function()? ontap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [

          TextFormField(
            maxLines:maxLine ?? 1 ,
            minLines: minLine,
            keyboardType: keyboardType,
            validator: validator,
            autovalidateMode:
            validator != null ? AutovalidateMode.onUserInteraction : null,
            controller: Controller,
            obscureText: ispassword,
            decoration:
            InputDecoration(label: Text(label,style: const TextStyle(fontSize: 16,
                color: Color(0xff80000000),fontWeight: FontWeight.bold),),
              fillColor: Colors.white,
              filled: true,
              border:  const OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
              prefixIcon:Icon(preIcon,color: const Color(0xff80000000),),
              suffixIcon: sufIcon != null ? IconButton(
                  onPressed: suffixPressed,
                  icon: Icon(sufIcon)):null,
            ),
            onTap: ontap,
            readOnly: !Clickable,
          ),
        ],
      ),
    );
  }
}
