
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sp_util/sp_util.dart';
import 'package:task_management/presentation/routes/pages.dart';
import 'package:task_management/presentation/widgets/confirm_dialog.dart';
import 'package:task_management/utils/color_palette.dart';

class NavigationDrawer extends StatefulWidget {
  final BuildContext context;
  const NavigationDrawer({super.key, required this.context});

  @override
  _NavigationDrawer createState() => _NavigationDrawer();
}

class _NavigationDrawer extends State<NavigationDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.

      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.white,
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    right: -50,
                    top: 0,
                    child: SvgPicture.asset("assets/images/illustration_2.svg", width: 300,),
                  ),
                  const Positioned(
                    left: 20,
                      top: 30,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 5, right: 16),
                            child: Text(
                              "Task Management",
                              textAlign: TextAlign.start,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: ColorPalette.darkBackground),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only( right: 16),
                            child: Text(
                              "Versi 1.0",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 12, color: ColorPalette.textPassive),
                            ),
                          ),

                        ],
                      )
                  )
                ],
              ),
            ),



            ListTile(
              contentPadding: const EdgeInsets.only(left: 30, right: 20),
              leading: SvgPicture.asset("assets/images/ic_lock.svg", color: ColorPalette.colorPrimary, width: 20,),
              title: const Text( "Change Password", style: TextStyle( color: ColorPalette.text, fontWeight: FontWeight.normal),),
              onTap: () async{
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/change_password");
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 30, right: 20),
              leading: SvgPicture.asset("assets/images/ic_info.svg", width: 22, color: ColorPalette.colorPrimary,),
              title: const Text( "About", style: TextStyle( color: ColorPalette.text, fontWeight: FontWeight.normal),),
              onTap: () async{
                Navigator.of(context).pop();
                // PackageInfo packageInfo = await PackageInfo.fromPlatform();
                
              },
            ),
            ListTile(
              contentPadding: const EdgeInsets.only(left: 30, right: 20),
              leading: SvgPicture.asset("assets/images/ic_help.svg", width: 20, color: ColorPalette.colorPrimary, ),
              title: const Text("Help", style: TextStyle( color: ColorPalette.text, fontWeight: FontWeight.normal),),
              onTap: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed("/help");
              },
            ),

            const Spacer(),
            ListTile(
              tileColor: ColorPalette.lightRed,
              title:  const Align(
                alignment: Alignment.center,
                child: Text("Log out", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
              ),
              onTap: () {

                Navigator.pop(context);
                showDialog(context: context, builder: (_) =>
                    ConfirmDialog(
                        icon: "assets/images/logout.svg",
                        message: "Are you sure want to log out?",
                        positiveText: "Yes",
                        negativeText: "Cancel",
                        onTapPositiveBtn: () async{
                            SpUtil.remove("IS_LOGIN");
                            Navigator.of(widget.context).pushNamedAndRemoveUntil(Pages.login, (route) => false);

                        }
                    )
                );
              },
            )

          ],
        ),
      ),
    );
  }
}
