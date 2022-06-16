import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halib/layout/cubit.dart';
import 'package:halib/layout/states.dart';
import 'package:halib/modules/default_price/default_price_screen.dart';
import 'package:halib/shared/components/applocal.dart';
import 'package:halib/shared/components/components.dart';
import 'package:halib/shared/network/local/cache_helper.dart';
import 'package:sizer/sizer.dart';

class PriceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocConsumer<MilkCubit, MilkStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.all(2.0.h),
              child: Column(
                children: [
                  Container(
                    alignment: AlignmentDirectional.center,
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
                          '${getLang(context, "bovinePrice")}',
                          style: TextStyle(fontSize: 17.sp),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text('${CacheHelper.getData(key: "bovinePrice")}')
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 5.h,
                  ),
                  Container(
                    alignment: AlignmentDirectional.center,
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
                          '${getLang(context, "buffaloPrice")}',
                          style: TextStyle(fontSize: 15.sp),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text('${CacheHelper.getData(key: "buffaloPrice")}')
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),

                  Container(
                    alignment: AlignmentDirectional.center,
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
                        Text('${getLang(context, "type")}'),
                        SizedBox(
                          width: 10.w,
                        ),
                        Text('${CacheHelper.getData(key: "typeOfCalculate")}')
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 10.h,
                  ),
                  mainButton(
                      text: '${getLang(context, "edit")}',
                      function: () {
                        navigateTo(context, DefaultPrice());
                      })

                  //buffaloPrice
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
