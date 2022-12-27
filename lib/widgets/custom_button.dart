import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {Key? key,
      required this.function,
      required this.child,
      this.backgroundColor,
      required this.width})
      : super(key: key);

  final Function? function;
  final Widget child;
  final double width;
  Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: (function == null) ? null : () {
          function!();
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Colors.grey;
          }
          return backgroundColor ?? backgroundColor;
        })),
        child: child,
      ),
    );
  }
}
