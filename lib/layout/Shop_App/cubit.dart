import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/Shop_App/states.dart';
import '../../../modules/shop_app/categories/categories_screen.dart';
import '../../../modules/shop_app/favorites/favorites_screen.dart';
import '../../../modules/shop_app/products/products_screen.dart';
import '../../models/shop_app/categories_model.dart';
import '../../models/shop_app/change_favorite_model.dart';
import '../../models/shop_app/favorites_model.dart';
import '../../models/shop_app/home_model.dart';
import '../../models/shop_app/user_model.dart';
import '../../modules/Shop_App/settings/settings_screen.dart';
import '../../shared/network/end_points.dart';
import '../../shared/network/remote/dio_helper.dart';
import '../../shared/shared_component/constants.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  bool isEng = true;
  TextDirection check = TextDirection.ltr;

  static String salla = 'Salla';
  static String home = 'Home';
  static String categories = 'Categories';
  static String products = 'Products';
  static String navFavorites = 'Favorites';
  static String setting = 'Settings';
  static String signOut = 'Sign out';
  static String update = 'Update Profile';
  static String lang = 'ع';

  int currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    CategoriesScreen(),
    const FavoritesScreen(),
    SettingScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    if (index == 2) {
      getFavData();
    }
    emit(ShopChangeBottomNavStates());
  }

  HomeModel? homeModel;
  Map<int, bool> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataStates());
    if (isEng) {
      DioHelper.getData(
        lang: 'en',
        url: HOME,
        token: token,
      ).then((value) {
        homeModel = HomeModel.fromJson(value.data);

        for (var element in homeModel!.data.products) {
          favorites.addAll({element.id: element.inFavorites});
        }
        //debugPrint(favorites.toString());
        emit(ShopSuccessHomeDataStates());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(ShopErrorHomeDataStates());
      });
    } else {
      DioHelper.getData(
        lang: 'ar',
        url: HOME,
        token: token,
      ).then((value) {
        homeModel = HomeModel.fromJson(value.data);

        for (var element in homeModel!.data.products) {
          favorites.addAll({element.id: element.inFavorites});
        }
        //debugPrint(favorites.toString());
        emit(ShopSuccessHomeDataStates());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(ShopErrorHomeDataStates());
      });
    }
  }

  CategoriesModel? categoriesModel;

  void getCategoryData() {
    if (isEng) {
      DioHelper.getData(
        lang: 'en',
        url: GET_CATEGORIES,
      ).then((value) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        emit(ShopSuccessCategoriesDataStates());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(ShopErrorCategoriesDataStates());
      });
    } else {
      DioHelper.getData(
        lang: 'ar',
        url: GET_CATEGORIES,
      ).then((value) {
        categoriesModel = CategoriesModel.fromJson(value.data);
        emit(ShopSuccessCategoriesDataStates());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(ShopErrorCategoriesDataStates());
      });
    }
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int productId) {
    bool checkValue = favorites[productId] as bool;
    favorites[productId] = !checkValue;
    emit(ShopChangeFavoritesDataStates());
    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productId,
      },
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      print(value.data);

      if (!changeFavoritesModel!.status) {
        favorites[productId] = !checkValue;
      } else {
        getFavData();
      }
      debugPrint(value.data.toString());
      emit(ShopSuccessChangeFavoritesDataStates(changeFavoritesModel!));
    }).catchError((error) {
      favorites[productId] = !checkValue;
      print(error.toString());
      emit(ShopErrorChangeFavoritesDataStates());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavData() {
    emit(ShopLoadingGetFavoritesDataStates());
    if (isEng) {
      DioHelper.getData(url: FAVORITES, lang: 'en', token: token).then((value) {
        favoritesModel = FavoritesModel.fromJson(value.data);
        emit(ShopSuccessGetFavoritesDataStates());
      }).catchError((error) {
        print(error.toString());
        emit(ShopErrorGetFavoritesDataStates());
      });
    } else {
      DioHelper.getData(url: FAVORITES, lang: 'ar', token: token).then((value) {
        favoritesModel = FavoritesModel.fromJson(value.data);
        debugPrint(favoritesModel?.status.toString());
        debugPrint(favoritesModel.toString());

        emit(ShopSuccessGetFavoritesDataStates());
      }).catchError((error) {
        debugPrint(error.toString());
        emit(ShopErrorGetFavoritesDataStates());
      });
    }
  }

  UserModel? userData;

  void getUserData() {
    emit(ShopLoadingUserDataStates());

    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userData = UserModel.fromJson(value.data);
      print(userData?.data.name.toString());
      emit(ShopSuccessUserDataStates(userData!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorUserDataStates());
    });
  }

  void updateUserData({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserDataStates());

    DioHelper.putData(
        url: UPDATE_PROFILE,
        token: token,
        data: {'name': name, 'email': email, 'phone': phone}).then((value) {
      userData = UserModel.fromJson(value.data);
      debugPrint(userData?.data.name.toString());
      emit(ShopSuccessUpdateUserDataStates(userData!));
    }).catchError((error) {
      debugPrint(error.toString());
      emit(ShopErrorUpdateUserDataStates());
    });
  }

  void changLang() async {
    isEng = !isEng;
    if (isEng) {
      check = TextDirection.ltr;
      salla = 'Salla';
      home = 'HOME';
      categories = 'CATEGORIES';
      products = 'products';
      navFavorites = 'FAVORITES';
      setting = 'SETTINGS';
      signOut = 'SIGN OUT';
      update = 'UPDATE';
      lang = 'ع';
    } else {
      check = TextDirection.rtl;
      salla = 'سلة';
      home = 'الرئيسيه';
      categories = 'المجموعات';
      navFavorites = 'المفضله';
      setting = 'الاعدادات';
      signOut = 'تسجيل الخروج';
      update = 'تحديث البيانات';
      products = 'المنتجات';
      lang = 'en';
    }
    emit(ShopLoadingHomeDataStates());
    getCategoryData();
    getHomeData();
    emit(ShopLoadingGetFavoritesDataStates());
    getFavData();
    emit(ShopChangeLangState());
  }
}
