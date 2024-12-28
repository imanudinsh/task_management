import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/utils/color_palette.dart';
import 'package:task_management/utils/enum/task_status.dart';
import 'package:task_management/utils/helper.dart';

class TaskItemView extends StatefulWidget {
  final Task taskModel;
  final VoidCallback onTapUpdateStatus;
  final VoidCallback onTapEdit;
  final VoidCallback onTapDelete;
  const TaskItemView({super.key, required this.taskModel, required this.onTapUpdateStatus, required this.onTapEdit, required this.onTapDelete});

  @override
  State<TaskItemView> createState() => _TaskItemViewState();
}

class _TaskItemViewState extends State<TaskItemView> {
  @override
  Widget build(BuildContext context) {
    var isDueDate = !(widget.taskModel.dueDate!.isAfter(DateTime.now()));
    return Container(
        margin: const EdgeInsets.only( left: 20, right: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              isDueDate && widget.taskModel.status == TaskStatus.InProgress? const Color(0xFFF8EAEC): widget.taskModel.status == TaskStatus.InProgress? const Color(0xFFE5EFFE):  widget.taskModel.status == TaskStatus.Completed ? const Color(0xFFE6F4EA): ColorPalette.cardGrey,
              Colors.white],
            stops: const [0.0, 1.0],
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: buildText(
                          widget.taskModel.title,
                          ColorPalette.text,
                          16,
                          FontWeight.bold,
                          TextAlign.start,
                          TextOverflow.clip)),
                      PopupMenuButton<int>(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        elevation: 1,
                        onSelected: (value) => value == 0 ? widget.onTapUpdateStatus(): value == 1 ? widget.onTapEdit(): widget.onTapDelete(),
                        itemBuilder: (BuildContext context) {
                          return [
                            PopupMenuItem<int>(
                              value: 0,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/ic_refresh.svg',
                                    width: 14,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildText(
                                      'Update status',
                                      ColorPalette.text,
                                      16,
                                      FontWeight.normal,
                                      TextAlign.start,
                                      TextOverflow.clip)
                                ],
                              ),
                            ),
                            PopupMenuItem<int>(
                              value: 1,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/ic_edit.svg',
                                    width: 20,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildText(
                                      'Edit task',
                                      ColorPalette.text,
                                      16,
                                      FontWeight.normal,
                                      TextAlign.start,
                                      TextOverflow.clip)
                                ],
                              ),
                            ),
                            PopupMenuItem<int>(
                              value: 2,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/ic_delete.svg',
                                    width: 18,
                                    color: ColorPalette.lightRed,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  buildText(
                                      'Delete task',
                                      ColorPalette.lightRed,
                                      16,
                                      FontWeight.normal,
                                      TextAlign.start,
                                      TextOverflow.clip)
                                ],
                              ),
                            ),
                          ];
                        },
                        child: SvgPicture.asset('assets/images/ic_menu_dots.svg', width: 12, color: ColorPalette.textPassive,),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(child: buildText(
                          widget.taskModel
                              .description,
                          ColorPalette.textPassive,
                          12,
                          FontWeight.normal,
                          TextAlign.start,
                          TextOverflow.clip)),
                      buildChip(
                          widget.taskModel.status.name,
                          isDueDate && widget.taskModel.status == TaskStatus.InProgress? ColorPalette.lightRed : widget.taskModel.status == TaskStatus.InProgress?ColorPalette.turqoise:  widget.taskModel.status == TaskStatus.Completed ? ColorPalette.colorPrimary: ColorPalette.textPassive,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Row(
                    children: [
                      SvgPicture.asset('assets/images/ic_calender.svg', width: 12, color: isDueDate && widget.taskModel.status == TaskStatus.InProgress  ? ColorPalette.lightRed: ColorPalette.text,),
                      const SizedBox(width: 10,),
                      Expanded(child: buildText(
                          formatDate(dateTime: widget.taskModel
                              .dueDate.toString()),  isDueDate && widget.taskModel.status == TaskStatus.InProgress ? ColorPalette.lightRed: ColorPalette.text, 10,
                          FontWeight.w400, TextAlign.start, TextOverflow.clip),)
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10,),
          ],
        ));
  }

  Text buildText(String text, Color color, double fontSize, FontWeight fontWeight,
      TextAlign textAlign, TextOverflow overflow) {
    return Text(
      text,
      textAlign: textAlign,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  Widget buildChip(String text, Color color) => Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: color.withOpacity(0.3), width: 1)
    ),
    child: Text(text, style: TextStyle(color: color, fontSize: 8),),
  );
}
