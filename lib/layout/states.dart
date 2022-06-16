import 'package:bloc/bloc.dart';

abstract class MilkStates {}

class MilkInitialState extends MilkStates {}

class MilkBottomNavBarChangeState extends MilkStates {}

class MilkDropdownValueChangeState extends MilkStates {}

class MilkCreateDatabaseState extends MilkStates {}

class MilkAddNewCustomerState extends MilkStates {}

class MilkGetCustomerLoadingState extends MilkStates {}

class MilkGetCustomerSuccessState extends MilkStates {}

class MilkAddNewAmountState extends MilkStates {}

class MilkAddNewWeekState extends MilkStates {}

class MilkGetWeeksLoadingState extends MilkStates {}

class MilkGetWeeksSuccessState extends MilkStates {}

class CalculateBillLoadingState extends MilkStates {}

class CalculateBillSuccessState extends MilkStates {}

class MilkUpdateWeeksLoadingState extends MilkStates {}

class MilkUpdateWeeksSuccessState extends MilkStates {}

class MilkGetAmountLoadingState extends MilkStates {}

class MilkGetAmountSuccessState extends MilkStates {}

class MilkCustomerUpdateState extends MilkStates {}

class MilkUpdateAmountLoadingState extends MilkStates {}

class MilkUpdateAmountSuccessState extends MilkStates {}
