import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halib/layout/cubit.dart';
import 'package:halib/layout/states.dart';
import 'package:halib/shared/components/applocal.dart';
import 'package:intl/intl.dart';

class HomeLayout extends StatelessWidget {
  var now = DateTime.now();
  late DateFormat dateFormat;
  @override
  Widget build(BuildContext context) {
    dateFormat = DateFormat.yMMMEd('${getLang(context, "dateLanguage")}');
    var cubit = MilkCubit.get(context);
    return BlocConsumer<MilkCubit, MilkStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Halib'),
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,

              statusBarIconBrightness:
                  Brightness.light, // For Android (dark icons)
            ),
          ),
          body: cubit.homeBodyScreens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.homeBottomNavChange(index, dateFormat.format(now));
              },
              items: cubit.homeBottomNavItem),
        );
      },
    );
  }
}
