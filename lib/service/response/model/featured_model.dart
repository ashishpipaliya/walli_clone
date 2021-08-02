class WallsModel {
  String id;
  String title;
  String description;
  int date;
  String artistId;
  String artistName;
  String artistBio;
  String artistAvatar;
  String likes;
  String downloads;
  String copyright;
  String location;
  DownloadLinks downloadLinks;

  WallsModel(
      {this.id,
      this.title,
      this.description,
      this.date,
      this.artistId,
      this.artistName,
      this.artistBio,
      this.artistAvatar,
      this.likes,
      this.downloads,
      this.copyright,
      this.location,
      this.downloadLinks});

  String get copyrightText => copyright.replaceAll('username', '').replaceAll("fullname", '').isNotEmpty ? "©$copyright" : '';

  static List<WallsModel> createFromList(dynamic json) {
    List<WallsModel> data = <WallsModel>[];
    if (json is List<dynamic>) {
      json.forEach((v) {
        data.add(new WallsModel.fromJson(v));
      });
    }
    return data;
  }

  WallsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    date = json['date'];
    artistId = json['artist_id'];
    artistName = json['artist_name'];
    artistBio = json['artist_bio'];
    artistAvatar = json['artist_avatar'];
    likes = json['likes'];
    downloads = json['downloads'];
    copyright = json['copyright'];
    location = json['location'];
    downloadLinks = json['download_links'] != null ? new DownloadLinks.fromJson(json['download_links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['date'] = this.date;
    data['artist_id'] = this.artistId;
    data['artist_name'] = this.artistName;
    data['artist_bio'] = this.artistBio;
    data['artist_avatar'] = this.artistAvatar;
    data['likes'] = this.likes;
    data['downloads'] = this.downloads;
    data['copyright'] = this.copyright;
    data['location'] = this.location;
    if (this.downloadLinks != null) {
      data['download_links'] = this.downloadLinks.toJson();
    }
    return data;
  }
}

class DownloadLinks {
  String thumbnail;
  String original;

  DownloadLinks({this.thumbnail, this.original});

  DownloadLinks.fromJson(Map<String, dynamic> json) {
    thumbnail = json['thumbnail'];
    original = json['original'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['thumbnail'] = this.thumbnail;
    data['original'] = this.original;
    return data;
  }
}
