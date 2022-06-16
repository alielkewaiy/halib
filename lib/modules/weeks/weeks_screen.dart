import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halib/layout/cubit.dart';
import 'package:halib/layout/states.dart';
import 'package:halib/modules/week_details/week_details.dart';
import 'package:halib/shared/components/applocal.dart';
import 'package:halib/shared/components/components.dart';
import 'package:sizer/sizer.dart';

class WeeksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocConsumer<MilkCubit, MilkStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Weeks'),
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,

                statusBarIconBrightness:
                    Brightness.light, // For Android (dark icons)
              ),
            ),
            body: ListView.separated(
                itemBuilder: (context, index) => weeksBuildItem(
                    context, MilkCubit.get(context).weeks[index]),
                separatorBuilder: (context, index) => Container(
                      height: 1.h,
                      width: double.infinity,
                      color: Colors.grey,
                    ),
                itemCount: MilkCubit.get(context).weeks.length),
          );
        },
      );
    });
  }

  Widget weeksBuildItem(context, Map model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
          onTap: () {
            MilkCubit.get(context).getWeekDetails(
                id: model['userId'], weekNumber: model['weekNumber']);
            navigateTo(context, WeekDetails());
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, .1),
                      offset: Offset(8, 14)),
                ],
                borderRadius: BorderRadiusDirectional.circular(20)),
            child: Padding(
              padding: EdgeInsets.all(2.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${model['firstDate']}',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      Text(
                        '${getLang(context, "theBill")}' ' :',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(
                        width: 9.w,
                      ),
                      Text(
                        '${model['bill']}',
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 1.h,
                  ),
                  Row(
                    children: [
                      Text(
                        '${getLang(context, "weekNumber")}' ' :',
                        style: TextStyle(fontSize: 15.sp),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text('${model['weekNumber']}',
                          style: TextStyle(fontSize: 16.sp)),
                    ],
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ب  :',
                        style: TextStyle(fontSize: 17.sp),
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Text(
                        '${model['bovineAmount']}',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                      SizedBox(
                        width: 25.w,
                      ),
                      Text(
                        'ج :',
                        style: TextStyle(fontSize: 17.sp),
                      ),
                      SizedBox(
                        width: 7.w,
                      ),
                      Text(
                        '${model['buffaloAmount']}',
                        style: TextStyle(fontSize: 18.sp),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
