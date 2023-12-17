import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_fonts.dart';
import '../../../../core/utils/app_string.dart';
import '../../../../features/task/presentation/cubit/task_cubit.dart';
import '../../../../features/task/presentation/cubit/task_states.dart';
import '../../../../features/task/presentation/screens/add_task_screen.dart';
import '../components/components.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(top: 34.0, left: 14.0, right: 14.0),
            child: BlocConsumer<TaskCubit, TaskStates>(
              listener: (context, state) {
                if (state is UpdateTasksSuccessState) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                var bloc = TaskCubit.get(context);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // time text
                    Row(
                      children: [
                        Text(
                          DateFormat.yMMMMd().format(DateTime.now()),
                          style: GoogleFonts.lato(
                              fontWeight: FontWeight.w700,
                              fontSize: FontSize.s24),
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {bloc.changeTheme();},
                            icon: const Icon(Icons.brightness_2_outlined))
                      ],
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    // today text
                    Text(
                      AppStrings.today,
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.w700, fontSize: FontSize.s24),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    // date picker timeline
                    SizedBox(
                      child: DatePicker(
                        DateTime.now(),
                        initialSelectedDate: DateTime.timestamp(),
                        selectionColor: AppColors.hcl,
                        deactivatedColor: AppColors.black,
                        height: 90.h,
                        width: 60.w,
                        selectedTextColor: AppColors.white,
                        dayTextStyle: GoogleFonts.lato(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w400),
                        dateTextStyle: GoogleFonts.lato(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w400),
                        monthTextStyle: GoogleFonts.lato(
                            fontSize: FontSize.s14,
                            fontWeight: FontWeight.w400),
                        onDateChange: (date) {
                          bloc.getSelectedDate(date);
                        },
                      ),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    // in case of task
                    bloc.taskList.isEmpty
                        ? const NoTasksComponent()
                        : SizedBox(
                            child: ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return TaskComponent(
                                    taskModel: bloc.taskList[index],
                                  );
                                },
                                separatorBuilder: (context, index) => SizedBox(
                                      height: 24.h,
                                    ),
                                itemCount: bloc.taskList.length),
                          ),
                  ],
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => const AddTasksScreen()));
          },
          backgroundColor: AppColors.offBlue,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
