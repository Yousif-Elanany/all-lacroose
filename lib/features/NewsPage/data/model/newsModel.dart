class NewsModel {
  int? id;
  int? langId;
  String? img;
  String? title;
  String? content;
  bool? oldOrNew;
  String? postTime;

  NewsModel(
      {this.id,
        this.langId,
        this.img,
        this.title,
        this.content,
        this.oldOrNew,
        this.postTime});

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    langId = json['langId'];
    img = json['img'];
    title = json['title'];
    content = json['description'];
    oldOrNew = json['oldOrNew'];
    postTime = json['postTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['langId'] = this.langId;
    data['img'] = this.img;
    data['title'] = this.title;
    data['description'] = this.content;
    data['oldOrNew'] = this.oldOrNew;
    data['postTime'] = this.postTime;
    return data;
  }
}