import 'package:control_page/const.dart';
import 'package:control_page/loginscreen/cubit/cubit.dart';
import 'package:flutter/material.dart';

Widget defualtForm({
  required BuildContext context,
  required TextEditingController controller,
  required TextInputType inputType,
  Function? onsubmit,
  required String validator,
  required String lable,
  IconData? prefix,
  IconData? postfix,
  bool hidden = false,
  Function? sufffun,
  required FocusNode myFocusNode,
}) =>
    TextFormField(
      validator: (String? value) {
        if (value == null || value.trim().isEmpty) {
          return validator;
        }

        return null;
      },
      controller: controller,
      keyboardType: inputType,
      obscureText: hidden,
      onFieldSubmitted: (s) {
        onsubmit!(s);
      },
      focusNode: myFocusNode,
      onTap: () {
        LoginCubit.get(context).onFocus(myFocusNode, context);
      },
      //function that i can do work on it

// ignore: prefer_const_constructors
      decoration: InputDecoration(
        //hintText: 'abc@examble.com',
        labelText: lable,
        labelStyle: TextStyle(color: Colors.black),
        border: const OutlineInputBorder(),
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: ColorTheme.gold,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(
            color: Colors.black,
          ),
        ),
        prefixIcon: Icon(
          prefix,
          color: myFocusNode.hasFocus ? ColorTheme.white : Colors.black,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            sufffun!();
          },
          icon: Icon(
            postfix,
            color: myFocusNode.hasFocus ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
