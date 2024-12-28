
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management/utils/color_palette.dart';

class EditTextFieldSearch extends StatelessWidget {
  const EditTextFieldSearch({
    super.key,
    required this.title,
    required this.textController,
    required this.enabled,
    this.onChanged,
  });

  final String title;
  final TextEditingController textController;
  final bool enabled;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            enabled: enabled ? true : false,
            controller: textController,
            keyboardType: TextInputType.text,
            cursorColor: ColorPalette.darkBackground,
            autofocus: false,
            onChanged: onChanged,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter $title';
              }
              return null;
            },
            decoration: InputDecoration(
              prefixIcon: Container(
                width: 40,
                alignment: Alignment.center,
                child: SvgPicture.asset( "assets/images/ic_search.svg", width: 18, color: ColorPalette.text),
              ),
              isDense: true,
              prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
              hintText: title,
              fillColor: enabled ? ColorPalette.cardGrey: ColorPalette.fieldDisable,
              filled: true,

              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide( color:  Colors.transparent, width: 0),
                  borderRadius: BorderRadius.circular(16)),
              disabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide( color: Colors.transparent, width: 0),
                  borderRadius: BorderRadius.circular(16)),
              errorBorder: OutlineInputBorder(
                  borderSide: const BorderSide( color: Colors.transparent, width: 0),
                  borderRadius: BorderRadius.circular(16)),
              focusedBorder:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16),
                borderSide:  const  BorderSide(color: Colors.transparent, width: 0),),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(16),
                borderSide:  const  BorderSide(color: Colors.transparent, width: 0),),
            ),
          ),
        ),
      ],
    );
  }
}
