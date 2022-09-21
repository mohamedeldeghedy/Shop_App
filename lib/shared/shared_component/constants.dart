//POST
//UPDATE
//DELETE

//GET()
//  (baseUrl) :  https://newsapi.org/
//  ( method) : v2/top-headlines?
//    (Query) : country=eg&category=business&apikey=66b28b209bec4d15876409dafe141dd0
//https://newsapi.org/v2/top-headlines?country=eg&category=business&apikey=66b28b209bec4d15876409dafe141dd0  *news*

//https://newsapi.org/v2/everything?q=s&apikey=66b28b209bec4d15876409dafe141dd0   *search*
import '../../modules/Shop_App/Login/shopLogin.dart';
import '../network/local/cash_helper.dart';
import 'components.dart';

void signOut(context) =>
    CacheHelper.removeData(key: 'token').then((bool? value) {
      if (value!) {
        navigateAndFinish(context, ShopLoginScreen());
      }
      // ShopCubit.get(context).emailController.clear();
      // ShopCubit.get(context).nameController.clear();
      // ShopCubit.get(context).phoneController.clear();
    });
void logOut(context) => CacheHelper.removeData(key: 'uId').then((bool? value) {
      if (value!) {
        navigateAndFinish(context, ShopLoginScreen());
      }
      // ShopCubit.get(context).emailController.clear();
      // ShopCubit.get(context).nameController.clear();
      // ShopCubit.get(context).phoneController.clear();
    });
String? token = '';
String? uId = '';
