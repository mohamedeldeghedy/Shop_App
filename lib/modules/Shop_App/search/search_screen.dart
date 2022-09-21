import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Shop_App/search/search_cubit.dart';
import 'package:shop_app/modules/Shop_App/search/search_states.dart';

import '../../../shared/shared_component/components.dart';

class SearchScreen extends StatelessWidget {
  var searchController = TextEditingController();

  SearchScreen({Key? key}) : super(key: key);
  //var article
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                      prefix: Icons.search,
                      label: 'Search',
                      raduis: 15,
                      onSubmit: (String? text) {
                        SearchCubit.get(context).getSearch(text!);
                      },
                      controller: searchController,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'enter text to search';
                        }
                        return null;
                      },
                      type: TextInputType.text,
                    ),
                    if (state is ShopGetSearchLoadingState)
                      LinearProgressIndicator(),
                    if (state is ShopGetSearchDataSucessState)
                      Expanded(
                        child: ListView.separated(
                          itemBuilder: (context, index) => buildListProduct(
                              SearchCubit.get(context)
                                  .model!
                                  .data!
                                  .data![index],
                              context,
                              isOldPrice: false),
                          separatorBuilder: (context, index) => myDivider(),
                          itemCount: SearchCubit.get(context)
                              .model!
                              .data!
                              .data!
                              .length,
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
