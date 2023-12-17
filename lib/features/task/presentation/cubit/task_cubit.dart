// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/database/cache_helper.dart';
import '../../../../core/database/sqflite_helper.dart';
import '../../../../core/services/service_locator.dart';
import '../../../../features/task/data/model/task_model.dart';
import '../../../../features/task/presentation/cubit/task_states.dart';
import '../../../../core/utils/app_colors.dart';

class TaskCubit extends Cubit<TaskStates> {
  TaskCubit() : super(TaskInitState());

  static TaskCubit get(context) => BlocProvider.of<TaskCubit>(context);

  final titleController = TextEditingController();

  final noteController = TextEditingController();

  final startTimeController = TextEditingController();

  final endTimeController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String title = "";
  String note = "";

  DateTime curDate = DateTime.now();
  DateTime selectedDate = DateTime.now();

  String startTime = DateFormat("hh:mm   ").format(DateTime.now());
  String endTime = DateFormat("hh:mm   ")
      .format(DateTime.now().add(const Duration(minutes: 45)));
  int curColorIndex = 0;
  List<TaskModel> taskList = [];

  void updateColorIndex(int i) {
    curColorIndex = i;
    emit(UpdateColorIndexState());
  }

  Color getColor(int i) {
    switch (i) {
      case 0:
        return AppColors.red;
      case 1:
        return AppColors.green;
      case 2:
        return AppColors.blueGray;
      case 3:
        return AppColors.blue;
      case 4:
        return AppColors.offYellow;
      case 5:
        return AppColors.gray;
      default:
        return AppColors.gray;
    }
  }

  onDatePressed(BuildContext context) async {
    emit(GetDateLoadingState());
    DateTime? pickedTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2030));
    if (pickedTime != null) {
      curDate = pickedTime;
      emit(GetDateSuccessState());
    } else {
      emit(GetDateErrorState());
    }
  }

  onStartTimePressed(BuildContext context) async {
    emit(GetStartTimeLoadingState());
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      startTime = pickedTime.format(context);
      emit(GetStartTimeSuccessState());
    } else {
      emit(GetStartTimeErrorState());
    }
  }

  onEndTimePressed(BuildContext context) async {
    emit(GetEndTimeLoadingState());
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null) {
      endTime = pickedTime.format(context);
      emit(GetEndTimeSuccessState());
    } else {
      emit(GetEndTimeErrorState());
    }
  }

  void insertTask() async {
    emit(InsertTaskLoadingState());
    try {
      await Future.delayed(const Duration(milliseconds: 250));
      await sl<SqfliteHelper>().writeData(TaskModel(
          title: titleController.text,
          note: noteController.text,
          startTime: startTime,
          endTime: endTime,
          date: DateFormat.yMMMMd().format(curDate),
          isCompleted: 0,
          color: curColorIndex));
      emit(InsertTaskSuccessState());
      handleAfterSuccessInsertion();
      getTasks();
    } catch (error) {
      log("Error while Inserting ${error.toString()}");
      emit(InsertTaskErrorState());
    }
  }

  void getTasks() async {
    emit(GetTasksLoadingState());
    try {
      await sl<SqfliteHelper>().readData().then((value) {
        taskList = value
            .map((e) => TaskModel.fromMap(e))
            .toList()
            .where((element) =>
                element.date == DateFormat.yMMMMd().format(selectedDate))
            .toList();
        emit(GetTasksSuccessState());
      });
    } catch (error) {
      log("Error while Reading ${error.toString()}");
      emit(GetTasksErrorState());
    }
  }

  void updateTasks(int id) async {
    emit(UpdateTasksLoadingState());
    try {
      await sl<SqfliteHelper>().updateData(id).then((value) {
        emit(UpdateTasksSuccessState());
        getTasks();
      });
    } catch (error) {
      log("Error while Updating ${error.toString()}");
      emit(UpdateTasksErrorState());
    }
  }

  void deleteTasks(int id) async {
    emit(DeleteTasksLoadingState());
    try {
      await sl<SqfliteHelper>().deleteData(id).then((value) {
        emit(DeleteTasksSuccessState());
        getTasks();
      });
    } catch (error) {
      log("Error while Deleting ${error.toString()}");
      emit(DeleteTasksErrorState());
    }
  }

  void getSelectedDate(DateTime date) {
    emit(GetSelectedDateLoadingState());
    selectedDate = date;
    emit(GetSelectedDateSuccessState());
    getTasks();
  }

  handleAfterSuccessInsertion() {
    title = titleController.text;
    note = noteController.text;
    titleController.clear();
    noteController.clear();
    startTime = DateFormat("hh:mm   a").format(DateTime.now());
    endTime = DateFormat("hh:mm   a")
        .format(DateTime.now().add(const Duration(minutes: 45)));
    curDate = DateTime.now();
    curColorIndex = 0;
  }

  bool isDark = false;
  bool? changeTheme({bool? fromShared}) {
    try {
      if (fromShared != null) {
        isDark = fromShared;
        emit(ChangeThemeState());
      } else {
        isDark = !isDark;
        CacheHelper().saveData(key: 'is-dark', value: isDark).then((value) => emit(ChangeThemeState()));
      }
    } catch (e) {
      log('Error While Saving Theme ${e.toString()}');
    }
    return null;
  }
}
