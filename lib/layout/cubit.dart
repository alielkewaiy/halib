import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halib/layout/states.dart';
import 'package:halib/modules/amount/amount_screen.dart';
import 'package:halib/modules/customer/customer_screen.dart';
import 'package:halib/modules/price/price_screen.dart';
import 'package:halib/shared/components/applocal.dart';
import 'package:halib/shared/components/components.dart';
import 'package:halib/shared/network/local/cache_helper.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class MilkCubit extends Cubit<MilkStates> {
  MilkCubit() : super(MilkInitialState());

  static MilkCubit get(context) => BlocProvider.of(context);

  bool checkNewWeek = true;
  int currentIndex = 0;
  List<BottomNavigationBarItem> homeBottomNavItem = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.supervised_user_circle), label: 'الزبائن'),
    const BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'الكمية'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.edit), label: 'السعر الافتراضي '),
  ];

  List<Widget> homeBodyScreens = [
    CustomerScreen(),
    AmountScreen(),
    PriceScreen(),
  ];

  void homeBottomNavChange(int index, String date) {
    currentIndex = index;
    if (index == 1) {
      getAmount(date: date);
    }
    emit(MilkBottomNavBarChangeState());
  }

  String? dropdownValueEditCustomer;
  void dropdownChangeEditCustomer(String? value) {
    dropdownValueEditCustomer = value;
    emit(MilkDropdownValueChangeState());
  }

  String? dropdownValueCreateCustomer;
  void dropdownChangeCreateCustomer(String? value) {
    dropdownValueCreateCustomer = value;
    emit(MilkDropdownValueChangeState());
  }

  String? dropdownValue;
  void dropdownChange(String? value) {
    dropdownValue = value;
    emit(MilkDropdownValueChangeState());
  }

  late Database database;
  void createDatabase() {
    openDatabase('milk.db', version: 1, onCreate: (database, version) {
      database
          .execute(
        'CREATE TABLE customers (id TEXT,name TEXT,type TEXT,bovinePrice TEXT,buffaloPrice TEXT,currentWeek INTEGER )',
      )
          .then((value) {
        print('table 1');
      });
      database
          .execute(
        'CREATE TABLE records (id TEXT,time TEXT,bovineِAmount TEXT ,buffaloAmount TEXT,date TEXT ,weekNumber TEXT)',
      )
          .then((value) {
        print('table 2');
      });

      database
          .execute(
        'CREATE TABLE weeks (userId TEXT,firstDate TEXT,weekNumber TEXT ,bill TEXT,bovineAmount TEXT,buffaloAmount TEXT )',
      )
          .then((value) {
        print('table 2');
      });
    }, onOpen: (database) {
      print('database open');
      getCustomer(database);
    }).then((value) {
      database = value;
      emit(MilkCreateDatabaseState());
    });
  }

  void addNewCustomer(
      {required String id,
      required String name,
      required String? type,
      required String? bovinePrice,
      required String? buffaloPrice,
      required String date}) async {
    int firstWeek = 1;
    if (dropdownValueCreateCustomer == null) {
      type = CacheHelper.getData(key: "typeOfCalculate");
    }
    if (bovinePrice == '') {
      bovinePrice = "default";
    }
    if (buffaloPrice == '') {
      buffaloPrice = "default";
    }
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO customers(id,name,type,bovinePrice,buffaloPrice,currentWeek) VALUES("$id","$name","$type","$bovinePrice","$buffaloPrice",$firstWeek)')
          .then((value) {
        print('new customer added');
        addNewWeek(
            userId: id, firstDate: date, weekNumber: firstWeek.toString());
        getCustomer(database);
        emit(MilkAddNewCustomerState());
      });
      return Future.value(true);
    });
  }

  void addNewAmount(
      {required String id,
      required String time,
      required String? date,
      required String? bovineAmount,
      required String? buffaloAmount,
      required String? weekNumber,
      required context,
      required String bovinePrice,
      required String buffaloPrice,
      required String caMethod}) async {
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO records(id,time,bovineِAmount,buffaloAmount,date,weekNumber) VALUES("$id","$time","$bovineAmount","$buffaloAmount","$date","$weekNumber")')
          .then((value) {
        print('new amount added');

        calculateBill(database,
            userId: id,
            weekNumber: weekNumber!,
            bovinePrice: bovinePrice,
            buffaloPrice: buffaloPrice,
            caMethod: caMethod);
        showToast(
            message: "${getLang(context, "toastSuccess")}",
            states: ToastStates.SUCCESS);
        emit(MilkAddNewAmountState());
      });
      return Future.value(true);
    });
  }

  List<Map> customers = [];
  void getCustomer(database) async {
    customers = [];
    emit(MilkGetCustomerLoadingState());
    database.rawQuery('SELECT * FROM customers').then((value) {
      value.forEach((element) {
        customers.add(element);
      });
      print(customers);
      emit(MilkGetCustomerSuccessState());
    });
  }

  void addNewWeek({
    required String userId,
    required String? firstDate,
    required String? weekNumber,
  }) async {
    String bill = '0';
    String bovineAmount = '0';
    String buffaloAmount = '0';
    await database.transaction((txn) {
      txn
          .rawInsert(
              'INSERT INTO weeks(userId,firstDate,weekNumber,bill,bovineAmount,buffaloAmount) VALUES("$userId","$firstDate","$weekNumber","$bill","$bovineAmount","$buffaloAmount")')
          .then((value) {
        checkNewWeek = false;
        print('new week added');

        emit(MilkAddNewWeekState());
      });
      return Future.value(true);
    });
  }

  List<Map> weeks = [];
  void getWeeks(database, String userId) async {
    weeks = [];
    emit(MilkGetWeeksLoadingState());
    database
        .rawQuery('SELECT * FROM weeks WHERE userId=?', [userId]).then((value) {
      value.forEach((element) {
        weeks.add(element);
      });
      print(weeks);
      emit(MilkGetWeeksSuccessState());
    });
  }

  void checkWeeks(database, String userId, String date) async {
    checkNewWeek = true;
    List<Map> checkNewWeeks = [];
    emit(MilkGetWeeksLoadingState());
    database.rawQuery('SELECT * FROM weeks WHERE userId=? AND firstDate=? ',
        [userId, date]).then((value) {
      value.forEach((element) {
        checkNewWeeks.add(element);
      });
      if (checkNewWeeks.isNotEmpty) {
        checkNewWeek = false;
      }
    });
  }

  void upDateCustomer(
      {required String id,
      int? newWeek,
      String? bovinePrice,
      String? buffaloPrice,
      String? caType}) async {
    if (newWeek != null) {
      database.rawUpdate('UPDATE customers SET currentWeek=? WHERE id=?',
          [newWeek, id]).then((value) {
        emit(MilkCustomerUpdateState());
      });
    }
    if (bovinePrice != null) {
      database.rawUpdate('UPDATE customers SET bovinePrice =? WHERE id=?',
          [bovinePrice, id]).then((value) {
        print('bovine price ');
        emit(MilkCustomerUpdateState());
      });
    }
    if (buffaloPrice != null) {
      database.rawUpdate('UPDATE customers SET buffaloPrice =? WHERE id=?',
          [buffaloPrice, id]).then((value) {
        print('buffalo price ');

        emit(MilkCustomerUpdateState());
      });
    }

    if (caType != null) {
      database.rawUpdate('UPDATE customers SET type =? WHERE id=?',
          [caType, id]).then((value) {
        print('method ca');
        print(caType);
        emit(MilkCustomerUpdateState());
      });
    }
    getCustomer(database);
  }

  double bovineAmount = 0;
  double buffaloAmount = 0;

  void calculateBill(database,
      {required String userId,
      required String weekNumber,
      required String bovinePrice,
      required String buffaloPrice,
      required String caMethod}) async {
    bovineAmount = 0;
    buffaloAmount = 0;
    emit(CalculateBillLoadingState());
    database.rawQuery('SELECT * FROM records WHERE id=? AND weekNumber=? ',
        [userId, weekNumber]).then((value) {
      value.forEach((element) {
        print(element['bovineِAmount']);
        double currentBovine = double.parse(element['bovineِAmount']);
        bovineAmount = currentBovine + bovineAmount;
        double currentBuffalo = double.parse(element['buffaloAmount']);
        buffaloAmount = buffaloAmount + currentBuffalo;
      });

      if (bovinePrice == "default") {
        bovinePrice = CacheHelper.getData(key: "bovinePrice");
      }
      if (buffaloPrice == "default") {
        buffaloPrice = CacheHelper.getData(key: "buffaloPrice");
      }

      late var bill = (bovineAmount * double.parse(bovinePrice)) +
          (buffaloAmount * double.parse(buffaloPrice));

      upDateWeek(
          userId: userId,
          weekNumber: weekNumber,
          bill: bill.toString(),
          bovineAmount: bovineAmount.toString(),
          buffaloAmount: buffaloAmount.toString());
      emit(CalculateBillSuccessState());
    });
  }

  void upDateWeek({
    required String userId,
    required String weekNumber,
    required String bill,
    required String bovineAmount,
    required String buffaloAmount,
  }) async {
    emit(MilkUpdateWeeksLoadingState());
    database.rawUpdate(
        'UPDATE weeks SET bill=?, bovineAmount=?, buffaloAmount=?  WHERE userId=? AND weekNumber=?',
        [bill, bovineAmount, buffaloAmount, userId, weekNumber]).then((value) {
      print("upDateWeek");
      emit(MilkUpdateWeeksSuccessState());
    });
  }

  double bovineAm = 0;
  double bovinePm = 0;
  double buffaloAm = 0;
  double buffaloPm = 0;
  void getAmount({required String date}) async {
    bovineAm = 0;
    bovinePm = 0;
    buffaloAm = 0;
    buffaloPm = 0;
    emit(MilkGetAmountLoadingState());

    database
        .rawQuery('SELECT * FROM records WHERE date=? ', [date]).then((value) {
      value.forEach((element) {
        if (element['time'] == 'am') {
          print(element);
          double currentBovine = double.parse('${element['bovineِAmount']}');
          bovineAm = bovineAm + currentBovine;
          double currentBuffalo = double.parse('${element['buffaloAmount']}');
          buffaloAm = buffaloAm + currentBuffalo;
        }

        if (element['time'] == 'pm') {
          double currentBovine = double.parse('${element['bovineِAmount']}');
          bovinePm = bovinePm + currentBovine;
          double currentBuffalo = double.parse('${element['buffaloAmount']}');
          buffaloPm = buffaloPm + currentBuffalo;
        }
      });
      emit(MilkGetAmountSuccessState());
    });
  }

  List<Map> listCheekAmount = [];
  bool boolCheekAmount = false;
  void cheekAmount(
      {required String id,
      required String time,
      required String date,
      required String weekNumber}) async {
    boolCheekAmount = false;
    await database.rawQuery(
        //id TEXT,time TEXT,bovineِAmount TEXT ,buffaloAmount TEXT,date TEXT ,weekNumber TEXT
        'SELECT * FROM records WHERE id=? AND time=? AND date=? AND weekNumber=? ',
        [id, time, date, weekNumber]).then((value) {
      value.forEach((element) {
        listCheekAmount.add(element);
      });
      if (listCheekAmount.isNotEmpty) {
        boolCheekAmount = true;
      }
      emit(MilkGetAmountSuccessState());
    });
  }

  void updateAmount(
      {required String bovine,
      required String buffalo,
      required String id,
      required String time,
      required String date,
      required String weekNumber,
      required context,
      required String bovinePrice,
      required String buffaloPrice,
      required String caMethod}) {
    emit(MilkUpdateAmountLoadingState());
    database.rawUpdate(
        'UPDATE records SET bovineِAmount=? , buffaloAmount=?  WHERE id=? AND time=? AND date=? AND weekNumber=?',
        [bovine, buffalo, id, time, date, weekNumber]).then((value) {
      print('update');

      calculateBill(database,
          userId: id,
          weekNumber: weekNumber!,
          bovinePrice: bovinePrice,
          buffaloPrice: buffaloPrice,
          caMethod: caMethod);
      showToast(
          message: "${getLang(context, "toastSuccess")}",
          states: ToastStates.SUCCESS);
      emit(MilkUpdateAmountSuccessState());
    });
  }

  List<String> fr = [];
  List<String> sa = [];
  List<String> su = [];
  List<String> mo = [];
  List<String> tu = [];
  List<String> we = [];
  List<String> th = [];

  void getWeekDetails({required String id, required String weekNumber}) {
    fr = ['0', '0', '0', '0'];
    sa = ['0', '0', '0', '0'];
    su = ['0', '0', '0', '0'];
    mo = ['0', '0', '0', '0'];
    tu = ['0', '0', '0', '0'];
    we = ['0', '0', '0', '0'];
    th = ['0', '0', '0', '0'];

    database.rawQuery('SELECT * FROM records WHERE id=? AND weekNumber=? ',
        [id, weekNumber]).then((value) {
      value.forEach((element) {
        if (element['date'].toString().contains('fr') ||
            element['date'].toString().contains('الجمع')) {
          if (element['time'].toString().contains('am')) {
            fr[0] = element['bovineِAmount'].toString();
            fr[1] = element['buffaloAmount'].toString();
          } else {
            fr[2] = element['bovineِAmount'].toString();
            fr[3] = element['buffaloAmount'].toString();
          }
        }
        if (element['date'].toString().contains('sa') ||
            element['date'].toString().contains('السبت')) {
          if (element['time'].toString().contains('am')) {
            sa[0] = element['bovineِAmount'].toString();
            sa[1] = element['buffaloAmount'].toString();
          } else {
            sa[2] = element['bovineِAmount'].toString();
            sa[3] = element['buffaloAmount'].toString();
          }
        }
        if (element['date'].toString().contains('su') ||
            element['date'].toString().contains('حد')) {
          if (element['time'].toString().contains('am')) {
            su[0] = element['bovineِAmount'].toString();
            su[1] = element['buffaloAmount'].toString();
          } else {
            su[2] = element['bovineِAmount'].toString();
            su[3] = element['buffaloAmount'].toString();
          }
        }
        if (element['date'].toString().contains('mo') ||
            element['date'].toString().contains('ثنين')) {
          if (element['time'].toString().contains('am')) {
            mo[0] = element['bovineِAmount'].toString();
            mo[1] = element['buffaloAmount'].toString();
          } else {
            mo[2] = element['bovineِAmount'].toString();
            mo[3] = element['buffaloAmount'].toString();
          }
        }
        if (element['date'].toString().contains('tu') ||
            element['date'].toString().contains('ثلاث')) {
          if (element['time'].toString().contains('am')) {
            tu[0] = element['bovineِAmount'].toString();
            tu[1] = element['buffaloAmount'].toString();
          } else {
            tu[2] = element['bovineِAmount'].toString();
            tu[3] = element['buffaloAmount'].toString();
          }
        }
        if (element['date'].toString().contains('we') ||
            element['date'].toString().contains('بعاء')) {
          if (element['time'].toString().contains('am')) {
            we[0] = element['bovineِAmount'].toString();
            we[1] = element['buffaloAmount'].toString();
          } else {
            we[2] = element['bovineِAmount'].toString();
            we[3] = element['buffaloAmount'].toString();
          }
        }
        if (element['date'].toString().contains('th') ||
            element['date'].toString().contains('الخميس')) {
          if (element['time'].toString().contains('am')) {
            th[0] = element['bovineِAmount'].toString();
            th[1] = element['buffaloAmount'].toString();
          } else {
            th[2] = element['bovineِAmount'].toString();
            th[3] = element['buffaloAmount'].toString();
          }
        }
      });
    });
  }
}
