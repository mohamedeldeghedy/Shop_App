import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../network/local/cash_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeNavBarState());
  }

  late Database database;
  bool isButtonShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isButtonShown = isShow;
    fabIcon = icon;
    emit(ChangeBottomSheetState());
  }

  bool isDark = false;
  ThemeMode AppMode = ThemeMode.dark;
  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared as bool;
      emit(AppChangeNewsModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeNewsModeState());
      });
    }
  }
}
