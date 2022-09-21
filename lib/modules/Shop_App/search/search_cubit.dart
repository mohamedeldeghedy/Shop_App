import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/Shop_App/search/search_states.dart';
import '../../../models/shop_app/search_model.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/shared_component/constants.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(ShopGetSearchDataInitialState());
  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? model;
  void getSearch(String value) {
    emit(ShopGetSearchLoadingState());

    DioHelper.postData(
      url: SEARCH,
      data: {'text': value},
      token: token,
    ).then((value) {
      model = SearchModel.fromJson(value.data);
      emit(ShopGetSearchDataSucessState());
    }).catchError((error) {
      print('error is ${error.toString()}');
      emit(ShopGetSearchDataErrorState(error));
    });
  }
}
