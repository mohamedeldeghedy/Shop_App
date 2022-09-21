class FavoritesModel {
  bool? status;
  String? message;
  late Data data;
  late FavoritesModel favoritesModel;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = (json['data'] != null ? Data.fromJson(json['data']) : null)!;
  }
}

class Data {
  int? currentPage;
  late List<FavData> data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FavData>[];
      json['data'].forEach((v) {
        data.add(FavData.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }
}

class FavData {
  int? id;
  late ProductData product;

  FavData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = (json['product'] != null
        ? ProductData.fromJson(json['product'])
        : null)!;
  }
}

class ProductData {
  late int id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  late String image;
  late String name;
  String? description;

  ProductData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}
