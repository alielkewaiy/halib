import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halib/layout/cubit.dart';
import 'package:halib/layout/home.dart';
import 'package:halib/layout/states.dart';
import 'package:halib/shared/components/applocal.dart';
import 'package:halib/shared/components/components.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class NewCustomerScreen extends StatelessWidget {
  var now = DateTime.now();
  late DateFormat dateFormat;
  @override
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var bovinePriceController = TextEditingController();
  var buffaloPriceController = TextEditingController();

  Widget build(BuildContext context) {
    dateFormat = DateFormat.yMMMEd('${getLang(context, "dateLanguage")}');
    String? dropValue;
    final dropList = [
      '${getLang(context, "kg")}',
      '${getLang(context, "alwajh")}'
    ];
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocConsumer<MilkCubit, MilkStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Halib'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(2.0.h),
                child: Column(
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 4.h,
                          ),
                          Row(
                            children: [
                              Text(
                                '${getLang(context, "customerName")}',
                                style: TextStyle(fontSize: 18.sp),
                              ),
                              SizedBox(
                                width: 6.w,
                              ),
                              Expanded(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return '${getLang(context, "nameErrorMessage")}';
                                    }
                                    return null;
                                  },
                                  controller: nameController,
                                  decoration: InputDecoration(
                                    labelText:
                                        '${getLang(context, "customerHint")}',
                                    border: const OutlineInputBorder(),
                                    prefixIcon: const Icon(Icons.person),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            children: [
                              Text(
                                '${getLang(context, "type")}',
                                style: TextStyle(fontSize: 17.sp),
                              ),
                              SizedBox(
                                width: 4.w,
                              ),
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsetsDirectional.only(
                                      start: 10, end: 10),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(10),
                                      border: Border.all(color: Colors.black)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      hint:
                                          Text('${getLang(context, "select")}'),
                                      isExpanded: true,
                                      value: MilkCubit.get(context)
                                          .dropdownValueCreateCustomer,
                                      items:
                                          dropList.map(buildMenuItem).toList(),
                                      onChanged: (value) {
                                        MilkCubit.get(context)
                                            .dropdownChangeCreateCustomer(
                                                value!);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 3.h,
                          ),
                          Row(
                            children: [
                              Text(
                                '${getLang(context, "bovinePrice")}',
                                style: TextStyle(fontSize: 17.sp),
                              ),
                              SizedBox(
                                width: 7.w,
                              ),
                              Expanded(
                                child: TextFormField(
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  controller: bovinePriceController,
                                  decoration: InputDecoration(
                                    labelText:
                                        '${getLang(context, "bovinePriceHint")}',
                                    border: const OutlineInputBorder(),
                                    prefixIcon: Icon(
                                      Icons.attach_money_outlined,
                                      size: 20.sp,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Text(
                                '${getLang(context, "buffaloPrice")}',
                                style: TextStyle(fontSize: 15.sp),
                              ),
                              SizedBox(
                                width: 3.w,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: buffaloPriceController,
                                  keyboardType:
                                      const TextInputType.numberWithOptions(
                                          decimal: true),
                                  decoration: InputDecoration(
                                    labelText:
                                        '${getLang(context, "buffaloPriceHint")}',
                                    border: const OutlineInputBorder(),
                                    prefixIcon:
                                        const Icon(Icons.attach_money_outlined),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 6.h,
                          ),
                        ],
                      ),
                    ),
                    mainButton(
                        text: '${getLang(context, "AddCustom")}',
                        function: () {
                          if (formKey.currentState!.validate()) {
                            var id =
                                10000000000 + Random.secure().nextInt(1000000);

                            MilkCubit.get(context).addNewCustomer(
                                id: id.toString(),
                                name: nameController.text,
                                type: MilkCubit.get(context)
                                    .dropdownValueCreateCustomer,
                                bovinePrice: bovinePriceController.text,
                                buffaloPrice: buffaloPriceController.text,
                                date: dateFormat.format(now));
                          }
                          navigateAndFinish(context, HomeLayout());
                        })
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ));
}
