// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/services/notifications_services.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../../features/task/presentation/components/components.dart';
import '../../../../features/task/presentation/cubit/task_cubit.dart';
import '../../../../features/task/presentation/cubit/task_states.dart';

class AddTasksScreen extends StatelessWidget {
  const AddTasksScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.black,
        appBar: AppBar(
          backgroundColor: AppColors.black,
          elevation: 0.0,
          centerTitle: false,
          title: Text(
            AppStrings.addTask,
            style: GoogleFonts.lato(
                fontWeight: FontWeight.w700,
                fontSize: FontSize.s30,
                color: AppColors.white87),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.h),
          child: SingleChildScrollView(
            child: BlocConsumer<TaskCubit, TaskStates>(
              listener: (context, state) {
                if (state is InsertTaskSuccessState) {
                  Navigator.pop(context);
                  sl<NotifyHelper>()
                      .showNotification(
                          body: TaskCubit.get(context).note,
                          title: TaskCubit.get(context).title,
                          fln: sl<NotifyHelper>().fln)
                      .then((value) => showToast(
                          msg: AppStrings.insertSuccess,
                          state: ToastState.success,
                          toastLen: ToastLength.short));
                }
              },
              builder: (context, state) {
                var bloc = TaskCubit.get(context);
                return Form(
                  key: bloc.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // title
                      AddTaskComponents(
                        text: AppStrings.title,
                        hintText: AppStrings.enterTitle,
                        controller: bloc.titleController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.titleError;
                          }
                          return null;
                        },
                      ),
                      //note
                      AddTaskComponents(
                        text: AppStrings.note,
                        hintText: AppStrings.enterNote,
                        controller: bloc.noteController,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return AppStrings.noteError;
                          }
                          return null;
                        },
                      ),
                      //date
                      AddTaskComponents(
                        text: AppStrings.date,
                        hintText: DateFormat.yMMMMd().format(bloc.curDate),
                        suffixIcon: Icons.calendar_month,
                        readOnly: true,
                        onTap: () async {
                          bloc.onDatePressed(context);
                        },
                      ),
                      //start and end time
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: AddTaskComponents(
                              text: AppStrings.startTime,
                              hintText: bloc.startTime,
                              controller: bloc.startTimeController,
                              readOnly: false,
                              suffixIcon: Icons.timer,
                              onTap: () async {
                                bloc.onStartTimePressed(context);
                              },
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          Expanded(
                            child: AddTaskComponents(
                              text: AppStrings.endTime,
                              hintText: bloc.endTime,
                              controller: bloc.endTimeController,
                              suffixIcon: Icons.timer,
                              onTap: () async {
                                bloc.onEndTimePressed(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      // task title
                      Text(
                        AppStrings.color,
                        style: GoogleFonts.lato(
                            color: AppColors.white87,
                            fontWeight: FontWeight.w400,
                            fontSize: FontSize.s16),
                      ),

                      SizedBox(
                        height: 68.0.h,
                        width: 276.w,
                        child: ListView.separated(
                            itemCount: 6,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            separatorBuilder: (context, index) => SizedBox(
                                  width: 5.w,
                                ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  bloc.updateColorIndex(index);
                                },
                                child: CircleAvatar(
                                  backgroundColor: bloc.getColor(index),
                                  child: index == bloc.curColorIndex
                                      ? Icon(
                                          Icons.check,
                                          color: AppColors.white,
                                        )
                                      : null,
                                ),
                              );
                            }),
                      ),
                      // task list of colors
                      SizedBox(
                        height: 92.h,
                      ),
                      // create task button
                      state is InsertTaskLoadingState
                          ? const Center(child: CircularProgressIndicator())
                          : Container(
                              width: double.maxFinite,
                              height: 48.0,
                              margin: const EdgeInsets.only(bottom: 10.0),
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                              ),
                              child: CustomTextButton(
                                  text: AppStrings.createTask,
                                  function: () {
                                    if (bloc.formKey.currentState!.validate()) {
                                      bloc.insertTask();
                                    }
                                  },
                                  color: AppColors.offBlue),
                            )
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
