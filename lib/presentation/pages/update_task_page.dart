import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management/data/model/task_model.dart';
import 'package:task_management/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:task_management/presentation/widgets/edit_text_field.dart';
import 'package:task_management/presentation/widgets/primary_button.dart';
import 'package:task_management/presentation/widgets/simple_app_bar.dart';
import 'package:task_management/presentation/widgets/text_view.dart';
import 'package:task_management/utils/color_palette.dart';
import 'package:task_management/utils/helper.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class UpdateTaskPage extends StatefulWidget {

  final Task taskModel;
  const UpdateTaskPage({required this.taskModel});

  @override
  State<UpdateTaskPage> createState() => _UpdateTaskPageState();
}

class _UpdateTaskPageState extends State<UpdateTaskPage> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _dueDate;

  _onSelected(DateTime? selectedDate, DateTime focusDay) {
    setState(() {
      _focusedDay = focusDay;
      _dueDate = selectedDate;
    });
  }

  @override
  void dispose() {
    title.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  void initState() {
    title.text = widget.taskModel.title;
    description.text = widget.taskModel.description;
    _dueDate = widget.taskModel.dueDate;
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: SimpleAppBar(
              title: 'Edit Task',
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
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: state.error,
                          ),
                        );
                      }
                      if (state is UpdateTaskSuccess) {
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
                                firstDay: DateTime.utc(2023, 1, 1),
                                lastDay: DateTime.utc(2030, 1, 1),
                                onPageChanged: (focusDay) {
                                  _focusedDay = focusDay;
                                },
                                rangeStartDay: _dueDate,
                                rangeEndDay: _dueDate,
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
                                child: TextView( _dueDate != null
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
                                  FontWeight.normal,
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
                                  FontWeight.normal,
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


                              SizedBox(
                                width: size.width,
                                child: PrimaryButton(
                                  title: "Edit",
                                  onTap: () {
                                    if (_dueDate == null) {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        const CustomSnackBar.error(
                                          message: "Please select due date",
                                        ),
                                      );
                                    }else if (_formKey.currentState!.validate()) {
                                      var task = Task(
                                          id: widget.taskModel.id,
                                          title: title.text,
                                          description: description.text,
                                          status: widget.taskModel.status,
                                          syncStatus: widget.taskModel.syncStatus,
                                          createdDate: widget.taskModel.createdDate,
                                          dueDate: _dueDate);
                                      context.read<TaskBloc>().add(
                                          UpdateTask(task));
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 20,)
                            ],
                          ));
                    })
                )
            )
        )
    );
  }
}
