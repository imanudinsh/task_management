
import 'package:flutter/material.dart';
import 'package:task_management/utils/color_palette.dart';

class EditTextField extends StatelessWidget {
  const EditTextField({
    Key? key,
    required this.title,
    required this.textController,
    required this.enabled,
    this.icon,
    this.inputType,
    this.maxLength,
    this.onChanged,
  }) : super(key: key);

  final String title;
  final TextEditingController textController;
  final bool enabled;
  final TextInputType? inputType;
  final int? maxLength;
  final Widget? icon;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            enabled: enabled ? true : false,
            controller: textController,
            keyboardType: inputType ?? TextInputType.text,
            cursorColor: ColorPalette.darkBackground,
            maxLength: maxLength,
            minLines: inputType == TextInputType.multiline? 3: null,
            maxLines: inputType == TextInputType.multiline? 5: null,
            autofocus: false,
            onChanged: onChanged,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $title';
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: icon!=null ? Container(
                width: 40,
                margin: const EdgeInsets.only(left: 8),
                alignment: Alignment.center,
                child: icon,
              ): null,
              isDense: false,
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical:16),
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              hintText: title,
              fillColor: enabled ? Colors.white: ColorPalette.fieldDisable,
              filled: true,

              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide( color: ColorPalette.text, width: 2),
                  borderRadius: BorderRadius.circular(30)),
              disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide( color: ColorPalette.fieldBorderDisable, width: 2),
                  borderRadius: BorderRadius.circular(30)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide( color: ColorPalette.lightRed, width: 2),
                  borderRadius: BorderRadius.circular(30)),
              focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                borderSide:  const  BorderSide(color: ColorPalette.colorPrimary, width: 2),),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(30),
                borderSide:  const  BorderSide(color: ColorPalette.colorPrimary, width: 2),),
            ),
          ),
        ),
      ],
    );
  }
}
