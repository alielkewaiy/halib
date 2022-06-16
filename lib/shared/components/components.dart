import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (context) => widget), (route) {
      return false;
    });

Widget defaultTextFormField({
  Function? showPassword,
  required TextEditingController controller,
  required TextInputType textInputType,
  Function? onChange,
  Function? onFieldSubmitted(value)?,
  FormFieldValidator<String>? validate,
  bool isPassword = true,
  Function? onTap,
  required String label,
  required IconData prefix,
  IconData? suffix,
  bool isClickable = true,
}) =>
    TextFormField(
      onChanged: (v) {
        onChange!(v);
      },
      enabled: isClickable,
      controller: controller,
      onTap: () {
        onTap!();
      },
      keyboardType: textInputType,
      onFieldSubmitted: (value) {
        onFieldSubmitted!(value);
      },
      validator: validate,
      obscureText: isPassword,
      decoration: InputDecoration(
          labelText: '$label',
          border: OutlineInputBorder(),
          prefixIcon: Icon(prefix),
          suffixIcon: IconButton(
              onPressed: () {
                showPassword!();
              },
              icon: Icon(suffix))),
    );

Widget mainButton({
  required String text,
  required Function function,
  double width = double.infinity,
  Color background = Colors.blue,
  bool? isUpperCase,
}) =>
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadiusDirectional.circular(10),
        color: background,
      ),
      width: width,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
        ),
      ),
    );

void showToast({required String message, required ToastStates states}) =>
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: choseToastColor(states),
        textColor: Colors.white,
        fontSize: 16.0);

enum ToastStates { SUCCESS, ERROR, WARING }

Color choseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARING:
      color = Colors.amber;
      break;
  }

  return color;
}
