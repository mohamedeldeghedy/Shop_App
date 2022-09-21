abstract class SearchStates {}

class ShopGetSearchDataInitialState extends SearchStates {}

class ShopGetSearchDataSucessState extends SearchStates {}

class ShopGetSearchLoadingState extends SearchStates {}

class ShopGetSearchDataErrorState extends SearchStates {
  final String error;
  ShopGetSearchDataErrorState(this.error);
}
