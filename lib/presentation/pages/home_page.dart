
import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_management/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:task_management/presentation/routes/pages.dart';
import 'package:task_management/presentation/widgets/change_status_dialog.dart';
import 'package:task_management/presentation/widgets/edit_text_field_search.dart';
import 'package:task_management/presentation/widgets/task_item_view.dart';
import 'package:task_management/presentation/widgets/navigation_drawer.dart' as navigator_drawer;
import 'package:task_management/utils/color_palette.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late StreamSubscription<List<ConnectivityResult>> subscription ;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<TaskBloc>().add(LoadTasks());
    super.initState();

    subscription = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      if(result.contains(ConnectivityResult.mobile) || result.contains(ConnectivityResult.wifi) ){
        context.read<TaskBloc>().add(SyncPendingTasks());
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocConsumer<TaskBloc, TaskState>(
        listener: (context, state) {
          if (state is TaskError) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: state.error,
              ),
            );
            debugPrint(state.error);
          }
          if ( state is TaskError) {
            // context.read<TaskBloc>().add(FetchTaskEvent());
          }
        }, builder: (context, state) {
      return ScaffoldMessenger(
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: Colors.white,
            appBar: AppBar(
              title: const Text('Task Management', style: TextStyle(color: ColorPalette.text, fontSize: 18, fontWeight: FontWeight.bold),),
              titleSpacing: 0,
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              elevation: 0,
              leading: Padding(
                  padding: const EdgeInsets.only(left: 0, right: 0),
                  child: IconButton(
                    onPressed:(){
                      scaffoldKey.currentState?.openDrawer();
                    },
                    icon: SvgPicture.asset("assets/images/ic_menu.svg", width: 20,),
                  )),
              leadingWidth: 60,
              actions: [
                PopupMenuButton<int>(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 1,
                  onSelected: (value) {
                    context
                        .read<TaskBloc>()
                        .add(SortTask(sortOption: value));
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<int>(
                        value: 0,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/ic_calender.svg',
                              width: 15,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                                'Sort by due date',
                                style: TextStyle(
                                    color: ColorPalette.text,
                                    fontSize: 16,
                                    overflow: TextOverflow.clip
                                )
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/ic_task_checked.svg',
                              width: 18,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                                'Completed tasks',
                                style: TextStyle(
                                    color: ColorPalette.text,
                                    fontSize: 16,
                                    overflow: TextOverflow.clip
                                )
                            )
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/ic_task.svg',
                              width: 15,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                                'In progress tasks',
                                style: TextStyle(
                                    color: ColorPalette.text,
                                    fontSize: 16,
                                    overflow: TextOverflow.clip
                                )
                            )

                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 3,
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/ic_task.svg',
                              width: 15,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text(
                                'Pending tasks',
                                style: TextStyle(
                                    color: ColorPalette.text,
                                    fontSize: 16,
                                    overflow: TextOverflow.clip
                                )
                            )

                          ],
                        ),
                      ),
                    ];
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24),
                    child: SvgPicture.asset('assets/images/ic_filter.svg', width: 20, color: ColorPalette.colorPrimary,),
                  ),
                ),
              ],
              bottom: state is TaskLoaded &&  state.tasks.isNotEmpty ? PreferredSize(preferredSize: const Size.fromHeight(80),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: EditTextFieldSearch(
                      title: "Search task ..",
                      textController: searchController,
                      enabled: true,
                      onChanged: (value) {
                        context.read<TaskBloc>().add(SearchTask(keyword: value));
                      },
                    ),
                  )): null,
            ),
            body: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => FocusScope.of(context).unfocus(),
                child: RefreshIndicator(
                  backgroundColor: Colors.white,
                  onRefresh: ()async {
                    return  context.read<TaskBloc>().add(LoadTasks());
                  },
                  child: state is TaskLoading ? const Center(
                      child: CupertinoActivityIndicator() ):
                  state is TaskLoaded && state.tasks.isNotEmpty
                  // || state.isSearching
                      ? Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemCount: state.tasks.length,
                              itemBuilder: (context, index) {
                                var item = state.tasks[index];
                                return TaskItemView(
                                  taskModel: item,
                                  onTapUpdateStatus: () async{
                                    await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return ChangeStatusDialog(
                                            task: item,
                                            onStatusChanged: (value) async{
                                              // Update status task di sini, misalnya dengan memanggil Bloc
                                              var updateTask = item;
                                              updateTask.status = value;
                                              context.read<TaskBloc>().add(UpdateTask(updateTask));
                                              context.read<TaskBloc>().add(LoadTasks());
                                            },
                                          );
                                        });
                                  },
                                  onTapEdit: () async{
                                    await Navigator.pushNamed(context, Pages.updateTask, arguments: item);
                                    context.read<TaskBloc>().add(LoadTasks());
                                  },
                                  onTapDelete: () async{
                                    context.read<TaskBloc>().add(DeleteTask(item.id!));
                                  },
                                );
                              }
                          ))
                    ],
                  )
                      : Container(
                    alignment: Alignment.center,
                    constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height - 100
                    ),
                      child:  ListView(
                        shrinkWrap: true,
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: [


                                SvgPicture.asset(
                                  'assets/images/illustration_3.svg',
                                  height: size.height * .25,
                                  width: size.width,
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                const Text(
                                  'Schedule your tasks',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: ColorPalette.text,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      overflow: TextOverflow.clip
                                  ),
                                ),
                                const Text(
                                  'Manage your task schedule easily\nand efficiently',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: ColorPalette.textPassive,
                                      fontSize: 12,
                                      overflow: TextOverflow.clip
                                  ),
                                ),

                        ],
                      )
                  )
                )
            ),
            drawer: navigator_drawer.NavigationDrawer(context: context,),
            floatingActionButton: FloatingActionButton(
                backgroundColor: ColorPalette.colorPrimary,
                shape: const OvalBorder(),
                elevation: 0,
                onPressed: () async {
                  await Navigator.pushNamed(context, Pages.createNewTask);
                  context.read<TaskBloc>().add(LoadTasks());
                },
                child:SvgPicture.asset(
                  'assets/images/ic_plus.svg',
                  width: 20,
                )),
          ));
    });
  }
}