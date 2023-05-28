import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class PopupUtil {
  static void showError(
      {required BuildContext context,
      required String message,
      required double width}) {
    AwesomeDialog(
      context: context,
      width: width,
      dialogType: DialogType.ERROR,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Opps...',
      desc: message,
      closeIcon: const Icon(Icons.close),
      btnOkOnPress: () {},
      autoHide: const Duration(seconds: 5),
    ).show();
  }

  static void showSuccess(
      {required BuildContext context,
      required String message,
      required double width,
      required Function()? onPress}) {
    AwesomeDialog(
      context: context,
      width: width,
      dialogType: DialogType.SUCCES,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Thành công',
      desc: message,
      btnOkOnPress: onPress,
    ).show();
  }
}
