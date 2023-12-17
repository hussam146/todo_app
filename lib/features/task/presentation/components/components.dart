// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../features/task/presentation/cubit/task_cubit.dart';
import '../../../../core/utils/app_string.dart';
import '../../data/model/task_model.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key,
      required this.text,
      required this.function,
      required this.color});
  final String text;
  final VoidCallback function;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: function,
      style: ElevatedButton.styleFrom(backgroundColor: color),
      child: Text(
        text,
        style: GoogleFonts.lato(
            fontWeight: FontWeight.w400,
            fontSize: FontSize.s16),
      ),
    );
  }
}

// +++++++++++++++++++++++++++++++

class AddTaskComponents extends StatelessWidget {
  AddTaskComponents(
      {super.key,
      required this.text,
      this.controller,
      required this.hintText,
      this.onTap,
      this.suffixIcon,
      this.validate,
      this.onChanged,
      this.readOnly = false});
  String text;
  final TextEditingController? controller;
  String hintText;
  final VoidCallback? onTap;
  IconData? suffixIcon;
  bool readOnly;
  String? Function(String?)? validate;
  void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.lato(
              fontWeight: FontWeight.w400,
              fontSize: FontSize.s16),
        ),
        SizedBox(
          height: 8.h,
        ),
        TextFormField(
          controller: controller,
          readOnly: readOnly,
          validator: validate,
          onChanged: onChanged,
          decoration: InputDecoration(
            
            hintText: hintText,
            suffixIcon: Icon(
              suffixIcon,
            ),
          ),
          onTap: onTap,
        ),
        SizedBox(
          height: 8.h,
        ),
      ],
    );
  }
}

// +++++++++++++++++++++++++++++++

class TaskComponent extends StatelessWidget {
  const TaskComponent({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                color: AppColors.offGray,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // complete task button
                      taskModel.isCompleted == 1
                          ? Container()
                          : Container(
                              width: double.maxFinite,
                              height: 48.0,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: CustomTextButton(
                                  text: AppStrings.completeTask,
                                  color: AppColors.offBlue,
                                  function: () {
                                    BlocProvider.of<TaskCubit>(context)
                                        .updateTasks(taskModel.id!);
                                  }),
                            ),
                      SizedBox(
                        height: 24.h,
                      ),
                      // delete task button
                      Container(
                        width: double.maxFinite,
                        height: 48.0,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: CustomTextButton(
                          text: AppStrings.deleteTask,
                          color: AppColors.offRed,
                          function: () {
                            BlocProvider.of<TaskCubit>(context)
                                .deleteTasks(taskModel.id!);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      // cancel task button
                      Container(
                        width: double.maxFinite,
                        height: 48.0,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        child: CustomTextButton(
                          text: AppStrings.cancel,
                          color: AppColors.offBlue,
                          function: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      },
      child: Container(
        decoration: BoxDecoration(
            color:
                BlocProvider.of<TaskCubit>(context).getColor(taskModel.color),
            borderRadius: const BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Flexible(
                flex: 3,
                fit: FlexFit.loose,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskModel.title,
                      style: GoogleFonts.lato(
                          color: AppColors.white87,
                          fontWeight: FontWeight.bold,
                          fontSize: FontSize.s24),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: AppColors.white,
                        ),
                        SizedBox(
                          width: 5.w,
                        ),
                        Text(
                          "${taskModel.startTime} - ${taskModel.endTime} ",
                          style: GoogleFonts.lato(
                              color: AppColors.white87,
                              fontWeight: FontWeight.w400,
                              fontSize: FontSize.s16),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      taskModel.note,
                      style: GoogleFonts.lato(
                          color: AppColors.white87,
                          fontWeight: FontWeight.w400,
                          fontSize: FontSize.s20),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Container(
                height: 60.0,
                width: 3.0,
                color: AppColors.white87,
              ),
              SizedBox(
                width: 10.w,
              ),
              RotatedBox(
                quarterTurns: 3,
                child: Text(
                  taskModel.isCompleted == 1
                      ? AppStrings.completed
                      : AppStrings.todo,
                  style: GoogleFonts.lato(
                      color: AppColors.white87,
                      fontWeight: FontWeight.w400,
                      fontSize: FontSize.s16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// +++++++++++++++++++++++++++++++

class NoTasksComponent extends StatelessWidget {
  const NoTasksComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Svg pic
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 73.h),
          child: SvgPicture.asset(
            AppAssets.noTasks,
            width: 227.w,
            height: 227.h,
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        // no tasks title
        Align(
          alignment: Alignment.center,
          child: Text(
            AppStrings.noTaskTitle,
            style: GoogleFonts.lato(
                fontSize: FontSize.s20,
                fontWeight: FontWeight.w400),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        // no tasks sub title
        Align(
          alignment: Alignment.center,
          child: Text(
            AppStrings.noTaskSubTitle,
            style: GoogleFonts.lato(
                fontSize: FontSize.s16,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
