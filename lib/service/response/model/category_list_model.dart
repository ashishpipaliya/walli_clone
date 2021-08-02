class CategoryListModel {
  String id;
  String name;
  String categoryName;
  String createdAt;
  String updatedAt;
  String position;
  String categoryThumbnail;
  String categoryImage;

  CategoryListModel({
    this.id,
    this.name,
    this.categoryName,
    this.createdAt,
    this.updatedAt,
    this.position,
    this.categoryThumbnail,
    this.categoryImage,
  });

  CategoryListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    categoryName = json['category_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    position = json['position'];
    categoryThumbnail = json['category_thumnail'];
    categoryImage = json['category_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['category_name'] = this.categoryName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['position'] = this.position;
    data['category_thumnail'] = this.categoryThumbnail;
    data['category_image'] = this.categoryImage;
    return data;
  }

  static List<CategoryListModel> createFromList(dynamic json) {
    List<CategoryListModel> data = <CategoryListModel>[];
    if (json is List<dynamic>) {
      json.forEach((v) {
        data.add(CategoryListModel.fromJson(v));
      });
    }
    return data;
  }
}
