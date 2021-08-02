class WallsRequest {
  int page;
  int perPage;
  String id;

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['page'] = this.page.toString();
   if(this.id != null){
     data['id'] = this.id.toString();
   }
    return data;
  }

  String get urlParams => '${page ?? 0}';
}

class CategoryListRequest {
  String page;

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['page'] = this.page;

    return data;
  }

// String get urlParams => '${page ?? 0}';
}


class RectangleWallRequest {
  String id;

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['image_id'] = this.id;
    return data;
  }
}
