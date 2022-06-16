import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halib/layout/cubit.dart';
import 'package:halib/layout/states.dart';
import 'package:halib/shared/components/applocal.dart';
import 'package:sizer/sizer.dart';

class WeekDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType)
    {
      return BlocConsumer<MilkCubit, MilkStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(10),
                      width: double.infinity,
                      height: 120,
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
                          Text('${getLang(context, "fr")}'),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(" "),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('${getLang(context, "bovineAmount")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('${getLang(context, "buffaloAmount")}'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${getLang(context, "morning")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .fr[0]),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .fr[1]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${getLang(context, "Evening")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .fr[2]),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .fr[3]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(10),
                      width: double.infinity,
                      height: 120,
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
                          Text('${getLang(context, "sa")}'),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(" "),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('${getLang(context, "bovineAmount")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('${getLang(context, "buffaloAmount")}'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${getLang(context, "morning")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .sa[0]),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .sa[1]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${getLang(context, "Evening")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .sa[2]),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .sa[3]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(10),
                      width: double.infinity,
                      height: 120,
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
                          Text('${getLang(context, "su")}'),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(" "),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('${getLang(context, "bovineAmount")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('${getLang(context, "buffaloAmount")}'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${getLang(context, "morning")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .su[0]),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .su[1]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${getLang(context, "Evening")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .su[2]),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .su[3]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(10),
                      width: double.infinity,
                      height: 120,
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
                          Text('${getLang(context, "mo")}'),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(" "),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('${getLang(context, "bovineAmount")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('${getLang(context, "buffaloAmount")}'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${getLang(context, "morning")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .mo[0]),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .mo[1]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${getLang(context, "Evening")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .mo[2]),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .mo[3]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(10),
                      width: double.infinity,
                      height: 120,
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
                          Text('${getLang(context, "tu")}'),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(" "),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('${getLang(context, "bovineAmount")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('${getLang(context, "buffaloAmount")}'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${getLang(context, "morning")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .tu[0]),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .tu[1]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${getLang(context, "Evening")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .tu[2]),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .tu[3]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(10),
                      width: double.infinity,
                      height: 120,
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
                          Text('${getLang(context, "we")}'),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(" "),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('${getLang(context, "bovineAmount")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('${getLang(context, "buffaloAmount")}'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${getLang(context, "morning")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .we[0]),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .we[1]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${getLang(context, "Evening")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .we[2]),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .we[3]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          )
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                    const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                    child: Container(
                      padding: const EdgeInsetsDirectional.all(10),
                      width: double.infinity,
                      height: 120,
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
                          Text('${getLang(context, "th")}'),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                const Text(" "),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('${getLang(context, "bovineAmount")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text('${getLang(context, "buffaloAmount")}'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${getLang(context, "morning")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .th[0]),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .th[1]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text('${getLang(context, "Evening")}'),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .th[2]),
                                const SizedBox(
                                  height: 12,
                                ),
                                Text(MilkCubit
                                    .get(context)
                                    .th[3]),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(),
                          )
                        ],
                      ),
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
