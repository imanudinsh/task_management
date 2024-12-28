import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:task_management/presentation/widgets/edit_text_field.dart';
import 'package:task_management/presentation/widgets/primary_button.dart';
import 'package:task_management/presentation/widgets/text_view.dart';
import 'package:task_management/utils/color_palette.dart';
import 'package:task_management/utils/enum/task_status.dart';
import 'package:task_management/utils/helper.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../widgets/simple_app_bar.dart';

class CreateTaskPage extends StatefulWidget {
  const CreateTaskPage({super.key});

  @override
  State<CreateTaskPage> createState() => _CreateTaskPageState();
}

class _CreateTaskPageState extends State<CreateTaskPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
  }

  _onSelected(DateTime? selectedDay, DateTime focusDay) {
    setState(() {
      _focusedDay = focusDay;
      _dueDate = selectedDay;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: SimpleAppBar(
              title: 'Create New Task',
              onTapBack: (){
                Navigator.of(context).pop();
              },
            ),
            body: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusScope.of(context).unfocus(),
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocConsumer<TaskBloc, TaskState>(
                        listener: (context, state) {
                      if (state is TaskError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            getSnackBar(state.error, ColorPalette.lightRed));
                      }
                      if (state is AddTaskSuccess) {
                        Navigator.pop(context);
                      }
                    }, builder: (context, state) {
                      return Form(
                          key: _formKey,
                          child: ListView(
                        physics: const BouncingScrollPhysics(),
                        children: [
                          TableCalendar(
                            calendarFormat: _calendarFormat,
                            startingDayOfWeek: StartingDayOfWeek.monday,
                            availableCalendarFormats: const {
                              CalendarFormat.month: 'Month',
                              CalendarFormat.week: 'Week',
                            },
                            rangeSelectionMode: RangeSelectionMode.toggledOn,
                            focusedDay: _focusedDay,
                            rangeStartDay: _dueDate,
                            rangeEndDay: _dueDate,
                            firstDay: DateTime.utc(2023, 1, 1),
                            lastDay: DateTime.utc(2030, 1, 1),
                            onPageChanged: (focusDay) {
                              _focusedDay = focusDay;
                            },

                            onFormatChanged: (format) {
                              if (_calendarFormat != format) {
                                setState(() {
                                  _calendarFormat = format;
                                });
                              }
                            },
                            onDaySelected: _onSelected,
                          ),
                          const SizedBox(height: 20),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: BoxDecoration(
                                color: ColorPalette.colorPrimary.withOpacity(.1),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5))),
                            child:  TextView( _dueDate != null
                                ? 'Due date at ${formatDate(dateTime: _dueDate.toString())}'
                                : 'Select a due date',
                                ColorPalette.text,
                                16,
                                FontWeight.w400,
                                TextAlign.start,
                                TextOverflow.clip),
                          ),
                          const SizedBox(height: 20),
                          TextView( 'Title',
                              ColorPalette.textPassive,
                              16,
                              FontWeight.w100,
                              TextAlign.start,
                              TextOverflow.clip),
                          const SizedBox(
                            height: 10,
                          ),
                          EditTextField(
                              title: "Task Title",
                              textController: title,
                              onChanged: (value) {},
                              maxLength: 30,
                              enabled: true
                          ),
                          TextView(
                              'Description',
                              ColorPalette.textPassive,
                              16,
                              FontWeight.w100,
                              TextAlign.start,
                              TextOverflow.clip),
                          const SizedBox(
                            height: 10,
                          ),
                          EditTextField(
                              title: "Task Description",
                              textController: description,
                              inputType: TextInputType.multiline,
                              onChanged: (value) {},
                              enabled: true
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      foregroundColor: ColorPalette.text,
                                      textStyle: const TextStyle(fontSize: 16),
                                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      elevation: 0,
                                      shadowColor: Colors.white,
                                    ),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: TextView(
                                        'Cancel',
                                        ColorPalette.text,
                                        16,
                                        FontWeight.w600,
                                        TextAlign.center,
                                        TextOverflow.clip)),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: PrimaryButton(
                                  title: "Save",
                                  onTap: () {
                                    if (_dueDate == null) {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.error(
                                          message: "Please select due date",
                                        ),
                                      );
                                    }else if (_formKey.currentState!.validate()) {
                                      var taskModel = Task(
                                          id: null,
                                          title: title.text,
                                          description: description.text,
                                          status: TaskStatus.InProgress,
                                          createdDate: DateTime.now(),
                                          dueDate: _dueDate);
                                      context.read<TaskBloc>().add(
                                          AddTask(taskModel));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                        ],
                          )
                      );
                    })))));
  }
}
