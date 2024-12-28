import 'package:flutter/material.dart';
import 'package:task_management/utils/color_palette.dart';

class PrimaryButton extends StatelessWidget  {
  PrimaryButton({Key? key, required this.title, this.disable = false, required this.onTap}) : super(key: key);

  final String title;
  final VoidCallback onTap;
  bool disable;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disable ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorPalette.colorPrimary,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16),
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 0,
        shadowColor: Colors.white,
      ),
      child: Text(title),
    );
  }


}
