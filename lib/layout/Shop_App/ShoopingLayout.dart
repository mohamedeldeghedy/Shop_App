import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/Shop_App/states.dart';

import '../../modules/Shop_App/search/search_screen.dart';
import '../../shared/shared_component/components.dart';
import 'cubit.dart';

class ShopLayout extends StatelessWidget {
  ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopCubit()
        ..getHomeData()
        ..getCategoryData()
        ..getFavData()
        ..getUserData(),
      child: BlocConsumer<ShopCubit, ShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(
                ShopCubit.salla,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              elevation: 2.0,
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                    size: 20,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      maxRadius: 18,
                      backgroundColor: Colors.white,
                      child: MaterialButton(
                        onPressed: () {
                          ShopCubit.get(context).changLang();
                        },
                        padding: EdgeInsets.zero,
                        minWidth: 2.0,
                        child: Text(
                          ShopCubit.lang,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.black),
                        ),
                      )),
                )
              ],
            ),
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              selectedFontSize: 16,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.orange.withOpacity(0.8),
              onTap: (index) {
                cubit.changeBottom(index);
              },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.home,
                    ),
                    label: ShopCubit.home),
                BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.dashboard_outlined,
                    ),
                    label: ShopCubit.categories),
                BottomNavigationBarItem(
                    icon: const Icon(
                      Icons.favorite,
                    ),
                    label: ShopCubit.navFavorites),
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.settings,
                  ),
                  label: ShopCubit.setting,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
