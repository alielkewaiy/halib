import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halib/layout/cubit.dart';
import 'package:halib/layout/states.dart';
import 'package:halib/modules/new_customer/new_customer_screen.dart';
import 'package:halib/shared/components/applocal.dart';
import 'package:halib/shared/components/components.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../add_amount/add_amount.dart';

class CustomerScreen extends StatelessWidget {
  var now = DateTime.now();
  late DateFormat dateFormat;
  @override
  Widget build(BuildContext context) {
    dateFormat = DateFormat.yMMMEd('${getLang(context, "dateLanguage")}');

    return Sizer(builder: (context, orientation, deviceType) {
      return BlocConsumer<MilkCubit, MilkStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: ConditionalBuilder(
                condition: MilkCubit.get(context).customers.isNotEmpty,
                builder: (context) => ListView.separated(
                    itemBuilder: (context, index) => customerBuildItem(
                        MilkCubit.get(context).customers[index], context),
                    separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Container(
                            color: Colors.grey[300],
                            height: 3,
                            width: double.infinity,
                          ),
                        ),
                    itemCount: MilkCubit.get(context).customers.length),
                fallback: (context) => Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: mainButton(
                            text: '${getLang(context, 'newCustom')}',
                            function: () {
                              navigateTo(context, NewCustomerScreen());
                            }),
                      ),
                    )),
            floatingActionButton: FloatingActionButton(
              child: const Icon(
                Icons.add,
                size: 25,
              ),
              onPressed: () {
                navigateTo(context, NewCustomerScreen());
              },
            ),
          );
        },
      );
    });
  }

  Widget customerBuildItem(Map model, context) => InkWell(
        onTap: () {
          MilkCubit.get(context).checkWeeks(MilkCubit.get(context).database,
              model['id'], dateFormat.format(now));

          MilkCubit.get(context)
              .getWeeks(MilkCubit.get(context).database, model['id']);
          navigateTo(
              context,
              AddAmountScreen(model['name'], model['id'], model['bovinePrice'],
                  model['buffaloPrice'], model['currentWeek'], model['type']));
        },
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Row(
            children: [
              CircleAvatar(
                radius: 4.h,
                child: Icon(
                  Icons.person,
                  size: 28.sp,
                ),
              ),
              SizedBox(
                width: 3.w,
              ),
              Text(
                '${model['name']}',
                style: TextStyle(
                  fontSize: 25.sp,
                ),
              ),
            ],
          ),
        ),
      );
}
