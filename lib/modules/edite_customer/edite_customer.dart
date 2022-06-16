import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halib/layout/home.dart';
import 'package:halib/modules/customer/customer_screen.dart';
import 'package:halib/shared/network/local/cache_helper.dart';
import 'package:sizer/sizer.dart';
import '../../layout/cubit.dart';
import '../../layout/states.dart';
import '../../shared/components/applocal.dart';
import '../../shared/components/components.dart';

class EditCustomerScreen extends StatelessWidget {
  String name;
  String id;
  String bovinePrice;
  String buffaloPrice;
  String calculateMethod;
  String currentWeek;

  EditCustomerScreen(this.name, this.id, this.bovinePrice, this.buffaloPrice,
      this.calculateMethod, this.currentWeek);

  GlobalKey<FormState> formKey = GlobalKey();
  var nameController = TextEditingController();
  var bovinePriceController = TextEditingController();
  var buffaloPriceController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    MilkCubit.get(context).dropdownValueEditCustomer = calculateMethod;
    nameController.text = name;
    bovinePriceController.text = bovinePrice == "default"
        ? CacheHelper.getData(key: "bovinePrice")
        : bovinePrice;
    buffaloPriceController.text = buffaloPrice == "default"
        ? CacheHelper.getData(key: "buffaloPrice")
        : buffaloPrice;
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
                                width: 2.w,
                              ),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsetsDirectional.only(
                                    start: 2.w,
                                    end: 2.w,
                                  ),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                          BorderRadiusDirectional.circular(7),
                                      border: Border.all(color: Colors.black)),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      hint: Text(calculateMethod),
                                      value: MilkCubit.get(context)
                                          .dropdownValueEditCustomer,
                                      items:
                                          dropList.map(buildMenuItem).toList(),
                                      onChanged: (value) {
                                        MilkCubit.get(context)
                                            .dropdownChangeEditCustomer(value!);
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
                                width: 5.w,
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
                                    prefixIcon:
                                        const Icon(Icons.attach_money_outlined),
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
                                '${getLang(context, "buffaloPrice")}',
                                style: TextStyle(fontSize: 15.sp),
                              ),
                              SizedBox(
                                width: 1.w,
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
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                    mainButton(
                        text: '${getLang(context, "btnSave")}',
                        function: () {
                          MilkCubit.get(context).upDateCustomer(
                              id: id,
                              buffaloPrice: buffaloPriceController.text,
                              bovinePrice: bovinePriceController.text,
                              caType: MilkCubit.get(context)
                                      .dropdownValueEditCustomer ??
                                  calculateMethod);
                          MilkCubit.get(context).calculateBill(
                              MilkCubit.get(context).database,
                              userId: id,
                              weekNumber: currentWeek,
                              bovinePrice: bovinePriceController.text,
                              buffaloPrice: buffaloPriceController.text,
                              caMethod: calculateMethod);
                          MilkCubit.get(context)
                              .getWeeks(MilkCubit.get(context).database, id);
                          showToast(
                              message: '${getLang(context, "toastSuccess")}',
                              states: ToastStates.SUCCESS);
                          navigateAndFinish(context, HomeLayout());
                        }
                        //  MilkCubit.get(context).getCustomer();
                        )
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
