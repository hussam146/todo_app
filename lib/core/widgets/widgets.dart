import 'package:flutter/animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/core/utils/app_colors.dart';

enum ToastLength { long, short }

enum ToastState { success, error, loading }

Color chooseToastColor(ToastState state) {
  Color color;
  switch (state) {
    case ToastState.success:
      color = AppColors.green;
      break;
    case ToastState.error:
      color = AppColors.red;
      break;
    case ToastState.loading:
      color = AppColors.offYellow;
      break;
  }
  return color;
}

Toast chooseToastLen(ToastLength toastLen) {
  Toast toast;
  switch (toastLen) {
    case ToastLength.long:
      toast = Toast.LENGTH_LONG;
      break;
    case ToastLength.short:
      toast = Toast.LENGTH_SHORT;
      break;
  }
  return toast;
}

Future showToast(
    {required String msg,
    required ToastState state,
    required ToastLength toastLen,
    ToastGravity gravity = ToastGravity.BOTTOM}) async {
  await Fluttertoast.showToast(
    msg: msg,
    backgroundColor: chooseToastColor(state),
    textColor: AppColors.white,
    toastLength: chooseToastLen(toastLen),
    fontSize: 16.0,
    gravity: gravity,
  );
}

Future cancelToast() async {
  await Fluttertoast.cancel();
}
