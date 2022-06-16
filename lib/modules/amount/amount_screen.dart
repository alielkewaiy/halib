import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halib/layout/cubit.dart';
import 'package:halib/layout/states.dart';
import 'package:intl/intl.dart';
import 'package:halib/shared/components/applocal.dart';
import 'package:sizer/sizer.dart';

class AmountScreen extends StatelessWidget {
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
            body: Padding(
              padding: EdgeInsets.all(3.0.h),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsetsDirectional.all(1.h),
                    height: 12.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, .1),
                              offset: Offset(8, 14)),
                        ],
                        borderRadius: BorderRadiusDirectional.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          dateFormat.format(now),
                          style: TextStyle(
                              fontSize: 23.sp, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 7.h,
                  ),
                  Container(
                    padding: EdgeInsetsDirectional.all(1.h),
                    width: double.infinity,
                    height: 20.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, .1),
                              offset: Offset(8, 14)),
                        ],
                        borderRadius: BorderRadiusDirectional.circular(20)),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              const Text(" "),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Text('${getLang(context, "bovineAmount")}'),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Text('${getLang(context, "buffaloAmount")}'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text('${getLang(context, "morning")}'),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Text('${MilkCubit.get(context).bovineAm}'),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Text('${MilkCubit.get(context).buffaloAm}'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text('${getLang(context, "Evening")}'),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Text('${MilkCubit.get(context).bovinePm}'),
                              SizedBox(
                                height: 1.5.h,
                              ),
                              Text('${MilkCubit.get(context).buffaloPm}'),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
