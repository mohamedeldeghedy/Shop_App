import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/cubit.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:shop_app/shared/network/local/cash_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/shared_component/Bloc_Observer.dart';
import 'package:shop_app/shared/shared_component/constants.dart';
import 'package:shop_app/shared/styles/themes.dart';
import 'layout/Shop_App/ShoopingLayout.dart';
import 'modules/Shop_App/Login/shopLogin.dart';
import 'modules/Shop_App/on_boarding/on_boarding_screen.dart';


void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();
  Widget widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token');
  uId = CacheHelper.getData(key: 'uId');
  print(uId);

  print(token);
  if (onBoarding != null) {
    if (token != null) {
      widget = ShopLayout();
    } else {
      widget = ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }


  BlocOverrides.runZoned(
        () {
      runApp(MyApp(
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  final Widget? startWidget;
  const MyApp({
     this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppCubit(),
        ),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightMode,
              darkTheme: darkMode,
              themeMode: ThemeMode.light,
              home:   startWidget
            //SocialLoginScreen() //startWidget //ShoppingLayout()startWidget,
          );
        },
      ),
    );
  }
}
