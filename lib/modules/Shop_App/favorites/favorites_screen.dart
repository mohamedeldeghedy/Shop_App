import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/Shop_App/cubit.dart';
import '../../../layout/Shop_App/states.dart';
import '../../../models/shop_app/favorites_model.dart';
import '../../../shared/shared_component/components.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          builder: (BuildContext context) => ListView.separated(
            itemBuilder: (context, index) => buildListItem(
                ShopCubit.get(context).favoritesModel!.data.data[index].product,
                context),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: ShopCubit.get(context).favoritesModel!.data.data.length,
          ),
          condition: ShopCubit.get(context).favoritesModel != null,
          fallback: (BuildContext context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildListItem(ProductData model, BuildContext context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(model.image),
                  height: 100.0,
                  width: 100,
                  fit: BoxFit.cover,
                ),
                if (model.discount != 0)
                  Container(
                    width: 70,
                    color: Colors.red,
                    child: const Text(
                      'Discount',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  )
              ],
            ),
            SizedBox(
              width: 30,
            ),
            Expanded(
              child: Container(
                alignment: AlignmentDirectional.topStart,
                color: Colors.white,
                child: Column(
                  children: [
                    Text(
                      model.name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text('${model.price}',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: 20,
                        ),
                        if (model.discount != 0)
                          Text('${model.oldPrice}',
                              style: TextStyle(
                                  decoration: TextDecoration.lineThrough)),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context).changeFavorites(model.id);
                          },
                          icon:
                              ShopCubit.get(context).favorites[model.id] as bool
                                  ? Icon(
                                      Icons.favorite,
                                      size: 25,
                                      color: Colors.red,
                                    )
                                  : Icon(
                                      Icons.favorite_border,
                                      size: 25,
                                      color: Colors.grey,
                                    ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      );
}
