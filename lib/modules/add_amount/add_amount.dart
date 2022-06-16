import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halib/layout/cubit.dart';
import 'package:halib/layout/states.dart';
import 'package:halib/modules/edite_customer/edite_customer.dart';
import 'package:halib/modules/new_customer/new_customer_screen.dart';
import 'package:halib/modules/weeks/weeks_screen.dart';
import 'package:halib/shared/components/applocal.dart';
import 'package:halib/shared/components/components.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class AddAmountScreen extends StatelessWidget {
  String name;
  String id;
  String bovinePrice;
  String buffaloPrice;
  String calculateMethod;
  int currentWeek;
  var bovineController = TextEditingController();
  var buffaloController = TextEditingController();

  AddAmountScreen(this.name, this.id, this.bovinePrice, this.buffaloPrice,
      this.currentWeek, this.calculateMethod);

  String x = DateFormat('hh:mm a').format(DateTime.now());
  var now = DateTime.now();
  late DateFormat dateFormat;

  @override
  Widget build(BuildContext context) {
    String time = 'am';
    if (x.contains('PM')) {
      time = "pm";
    }
    dateFormat = DateFormat.yMMMEd('${getLang(context, "dateLanguage")}');
    MilkCubit.get(context).cheekAmount(
        id: id,
        time: time,
        date: dateFormat.format(now),
        weekNumber: currentWeek.toString());

    if (MilkCubit.get(context).checkNewWeek &&
        (dateFormat.format(now).contains('Fr') ||
            dateFormat.format(now).contains('الجمعة'))) {
      currentWeek = currentWeek + 1;
      MilkCubit.get(context).addNewWeek(
          userId: id,
          firstDate: dateFormat.format(now),
          weekNumber: (currentWeek).toString());
      MilkCubit.get(context).upDateCustomer(id: id, newWeek: currentWeek);
    }
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocConsumer<MilkCubit, MilkStates>(
        listener: (context, state) {
          MilkCubit.get(context).checkNewWeek;
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              titleSpacing: 3.w,
              title: Text(
                name,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      navigateTo(
                          context,
                          EditCustomerScreen(
                              name,
                              id,
                              bovinePrice,
                              buffaloPrice,
                              calculateMethod,
                              currentWeek.toString()));
                    },
                    icon: Icon(
                      Icons.settings,
                      color: Colors.blue,
                      size: 30.sp,
                    ))
              ],
              backgroundColor: Colors.white,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(2.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${getLang(context, "theDay")}',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dateFormat.format(now),
                          style: TextStyle(fontSize: 20.sp),
                        )
                      ],
                    ),
                    if (x.contains('AM'))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${getLang(context, "morning")}',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 22.sp),
                          ),
                        ],
                      ),
                    if (x.contains('PM'))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('${getLang(context, "Evening")}',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.sp)),
                        ],
                      ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              '${getLang(context, "bovineAmount")}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(
                              width: 8.w,
                            ),
                            Expanded(
                                child: defaultTextFormField(
                                    isPassword: false,
                                    controller: bovineController,
                                    textInputType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    label:
                                        '${getLang(context, "bovineAmountHint")}',
                                    prefix: Icons.science))
                          ],
                        ),
                        SizedBox(
                          height: 3.h,
                        ),
                        Row(
                          children: [
                            Text(
                              '${getLang(context, "buffaloAmount")}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.sp,
                              ),
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Expanded(
                                child: defaultTextFormField(
                                    isPassword: false,
                                    controller: buffaloController,
                                    textInputType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    label:
                                        '${getLang(context, "buffaloAmountHint")}',
                                    prefix: Icons.science))
                          ],
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        mainButton(
                            text: "${getLang(context, "btnSave")}",
                            function: () {
                              var bovine = double.parse(bovineController.text);
                              var buffalo =
                                  double.parse(buffaloController.text);
                              if (calculateMethod ==
                                  '${getLang(context, "alwajh")}') {
                                bovine =
                                    double.parse(bovineController.text) * 2.5;
                                buffalo =
                                    double.parse(buffaloController.text) * 2.5;
                              }

                              if (MilkCubit.get(context).boolCheekAmount) {
                                MilkCubit.get(context).updateAmount(
                                    bovine: bovine.toString(),
                                    buffalo: buffalo.toString(),
                                    id: id,
                                    time: time,
                                    date: dateFormat.format(now),
                                    weekNumber: currentWeek.toString(),
                                    context: context,
                                    bovinePrice: bovinePrice,
                                    buffaloPrice: buffaloPrice,
                                    caMethod: calculateMethod);
                              } else {
                                MilkCubit.get(context).addNewAmount(
                                    id: id,
                                    time: time,
                                    date: dateFormat.format(now),
                                    bovineAmount: bovine.toString(),
                                    buffaloAmount: buffalo.toString(),
                                    weekNumber: currentWeek.toString(),
                                    context: context,
                                    bovinePrice: bovinePrice,
                                    buffaloPrice: buffaloPrice,
                                    caMethod: calculateMethod);
                              }

                              buffaloController.clear();
                              bovineController.clear();
                            }),
                      ],
                    ),
                    SizedBox(
                      height: 4.h,
                    ),
                    mainButton(
                        text: '${getLang(context, "btnRecords")}',
                        function: () {
                          MilkCubit.get(context)
                              .getWeeks(MilkCubit.get(context).database, id);
                          navigateTo(context, WeeksScreen());
                        }),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
