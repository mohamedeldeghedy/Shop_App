import '../../models/shop_app/LoginModel.dart';
import '../../models/shop_app/change_favorite_model.dart';
import '../../models/shop_app/user_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates {}

class ShopChangeBottomNavStates extends ShopStates {}

class ShopLoadingHomeDataStates extends ShopStates {}

class ShopSuccessHomeDataStates extends ShopStates {}

class ShopErrorHomeDataStates extends ShopStates {}

class ShopLoadingCategoriesDataStates extends ShopStates {}

class ShopSuccessCategoriesDataStates extends ShopStates {}

class ShopErrorCategoriesDataStates extends ShopStates {}

class ShopSuccessChangeFavoritesDataStates extends ShopStates {
  final ChangeFavoritesModel model;

  ShopSuccessChangeFavoritesDataStates(this.model);
}

class ShopChangeFavoritesDataStates extends ShopStates {}

class ShopErrorChangeFavoritesDataStates extends ShopStates {}

class ShopSuccessGetFavoritesDataStates extends ShopStates {}

class ShopLoadingGetFavoritesDataStates extends ShopStates {}

class ShopErrorGetFavoritesDataStates extends ShopStates {}

class ShopSuccessUserDataStates extends ShopStates {
  final UserModel? loginModel;

  ShopSuccessUserDataStates(this.loginModel);
}

class ShopLoadingUserDataStates extends ShopStates {}

class ShopErrorUserDataStates extends ShopStates {}

class ShopSuccessUpdateUserDataStates extends ShopStates {
  final UserModel? loginModel;

  ShopSuccessUpdateUserDataStates(this.loginModel);
}

class ShopLoadingUpdateUserDataStates extends ShopStates {}

class ShopErrorUpdateUserDataStates extends ShopStates {}

class ShopChangeLangState extends ShopStates {}
