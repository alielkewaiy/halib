import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halib/layout/cubit.dart';
import 'package:halib/layout/home.dart';
import 'package:halib/layout/states.dart';
import 'package:halib/shared/components/applocal.dart';
import 'package:halib/shared/components/components.dart';
import 'package:halib/shared/network/local/cache_helper.dart';
import 'package:sizer/sizer.dart';

class DefaultPrice extends StatelessWidget {
  var bovinePriceController = TextEditingController();
  var buffaloPriceController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late String caType;
  @override
  Widget build(BuildContext context) {
    bovinePriceController.text =
        CacheHelper.getData(key: "bovinePrice") ?? bovinePriceController.text;
    buffaloPriceController.text =
        CacheHelper.getData(key: "buffaloPrice") ?? buffaloPriceController.text;
    caType = CacheHelper.getData(key: "typeOfCalculate") ??
        '${getLang(context, "select")}';
    return Sizer(builder: (context, orientation, deviceType) {
      return BlocConsumer<MilkCubit, MilkStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final dropList = [
            '${getLang(context, "kg")}',
            '${getLang(context, "alwajh")}'
          ];

          return Scaffold(
            appBar: AppBar(
              systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,

                statusBarIconBrightness:
                    Brightness.light, // For Android (dark icons)
              ),
              title: Text('${getLang(context, "defaultPriceTitle")}'),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: 3.h, bottom: 3.h, right: 2.w, left: 2.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${getLang(context, "type")}',
                          style: const TextStyle(fontSize: 18),
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsetsDirectional.only(
                                start: 10, end: 10),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadiusDirectional.circular(10),
                                border: Border.all(color: Colors.black)),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text(caType),
                                value: MilkCubit.get(context).dropdownValue,
                                items: dropList.map(buildMenuItem).toList(),
                                onChanged: (value) {
                                  MilkCubit.get(context).dropdownChange(value!);
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                '${getLang(context, "bovinePrice")}',
                                style: const TextStyle(fontSize: 18),
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
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return '${getLang(context, "validationEnterThePrice")}';
                                    }
                                    return null;
                                  },
                                  // onChanged: (value) {
                                  //   bovinePriceController.text = value;
                                  // },
                                  decoration: InputDecoration(
                                    labelText:
                                        '${getLang(context, "bovinePriceHint")}',
                                    border: const OutlineInputBorder(),
                                    prefixIcon:
                                        const Icon(Icons.attach_money_outlined),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Row(
                            children: [
                              Text(
                                '${getLang(context, "buffaloPrice")}',
                                style: const TextStyle(fontSize: 17),
                              ),
                              SizedBox(
                                width: 1.5.w,
                              ),
                              Expanded(
                                child: TextFormField(
                                  // onChanged: (value) {
                                  //   buffaloPriceController.text = value;
                                  // },
                                  controller: buffaloPriceController,
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return '${getLang(context, "validationEnterThePrice")}';
                                    }
                                    return null;
                                  },
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
                        text: '${getLang(context, "btnSave")}',
                        function: () {
                          if (formKey.currentState!.validate()) {
                            CacheHelper.saveData(
                                key: "bovinePrice",
                                value: bovinePriceController.text);
                            CacheHelper.saveData(
                                key: "buffaloPrice",
                                value: buffaloPriceController.text);
                            String typeOfCalculate =
                                MilkCubit.get(context).dropdownValue == null
                                    ? '${getLang(context, "alwajh")}'
                                    : MilkCubit.get(context).dropdownValue!;
                            CacheHelper.saveData(
                                key: "typeOfCalculate", value: typeOfCalculate);

                            navigateAndFinish(context, HomeLayout());
                          }
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

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
      value: item,
      child: Text(
        item,
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ));
}
