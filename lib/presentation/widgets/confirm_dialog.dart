
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_management/presentation/widgets/primary_button.dart';
import 'package:task_management/utils/color_palette.dart';

class ConfirmDialog extends StatelessWidget {
  final String icon;
  final String message;
  final String positiveText;
  final String? negativeText;
  final Function onTapPositiveBtn;
  final Function? onTapNegativeBtn;

  const ConfirmDialog({
    Key? key,
    required this.icon,
    required this.message,
    required this.positiveText,
    this.negativeText,
    required this.onTapPositiveBtn,
    this.onTapNegativeBtn
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.all(0),
      elevation: 5,
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(18.0) ),
      content: SizedBox(
        width: MediaQuery.of(context).size.width/2,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 30 ),
              child: icon.substring(icon.length-3) == "svg" ? SvgPicture.asset(icon, width: 60, height: 60): Image.asset(icon, width: 60, height: 60),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 40, right: 40),
              child: Text(message, textAlign: TextAlign.center ,style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ColorPalette.text)),
            ),

            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  negativeText != null ? InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        (onTapNegativeBtn ?? (){})();
                      },
                    child:  Text(negativeText!, style: TextStyle(color: ColorPalette.darkBackground),),
                  ): const Text(""),
                  const SizedBox(
                    width: 20,
                  ),
                  PrimaryButton(
                      title: positiveText,
                      onTap: () {
                        Navigator.pop(context);
                        onTapPositiveBtn();
                      }
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

}