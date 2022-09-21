import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Shop_App/register/register_states.dart';
import '../../../models/shop_app/LoginModel.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);
  ShopLoginModel? loginModel;

  void registerUsers({
    required String email,
    required String password,
    required String name,
    required String phone,
    String? image,
  }) {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(url: Register, data: {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'image': image
    }).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      print(value.toString());
      emit(ShopRegisterSuccessState(loginModel!));
    }).catchError((error) {
      emit(ShopRegisterErrorState(error.toString()));
      debugPrint(error.toString());
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_off_outlined;

  void changePasswordVisibility() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    emit(ShopRegisterChangPasswordVisibilityState());
  }

  @override
  Future<void> close() {
    // TODO: implement close
    return super.close();
  }
}
