class CategoriesModel {
  late bool status;
  late CategoriesDataModel data;
  late CategoriesModel categoriesModel;
  CategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel {
  late int currentPage;
  List<Data_Model> data = [];

  CategoriesDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    json['data'].forEach((element) {
      data.add(Data_Model.fromJson(element));
    });
  }
}

class Data_Model {
  late int id;
  late String name;
  late String image;

  Data_Model.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}
