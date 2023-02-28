import 'package:control_page/const.dart';
import 'package:flutter/material.dart';

Widget button({
  required String text,
  required VoidCallback onpress,
  required double width,
  required double height,
  required BuildContext context,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: ColorTheme.gold,
        borderRadius: BorderRadius.circular(height * 0.4),
        boxShadow: [
          BoxShadow(
            color: ColorTheme.gold.withOpacity(0.5),
            blurRadius: 12,
            offset: const Offset(0, 12),
          ),
          const BoxShadow(
            color: ColorTheme.gold,
            offset: Offset(12, 0),
          ),
          const BoxShadow(
            color: ColorTheme.gold,
            offset: Offset(-12, 0),
          ),
        ],
      ),
      child: MaterialButton(
        // ignore: curly_braces_in_flow_control_structures
        onPressed: onpress,
        // ignore: curly_braces_in_flow_control_structures
        child: Text(text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                  // fontWeight: FontWeight.bold,
                )),
      ),
    );
