class NewsModel {
  final int? id;
  final int? langId;
  final String? img;
  final String? title;
  final String? content;
  final bool? oldOrNew;
  final String? postTime;
  final List<NewsDetailModel>? newsDetails;

  const NewsModel({
    this.id,
    this.langId,
    this.img,
    this.title,
    this.content,
    this.oldOrNew,
    this.postTime,
    this.newsDetails,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      langId: json['langId'],
      img: json['img'],
      title: json['title'],
      content: json['description'],
      oldOrNew: json['oldOrNew'],
      postTime: json['postTime'],
      newsDetails: (json['newsDetails'] as List?)
          ?.map((e) => NewsDetailModel.fromJson(e))
          .toList(),
    );
  }

  /// الشكل الكامل (زي ما هو في الـ API)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'langId': langId,
      'img': img,
      'title': title,
      'description': content,
      'oldOrNew': oldOrNew,
      'postTime': postTime,
      'newsDetails': newsDetails?.map((e) => e.toJson()).toList(),
    };
  }

  /// الشكل الخاص بالتعديل (اللي محتاجه API update)
  Map<String, dynamic> toUpdateJson() {
    return {
      'id': id ?? 0, // لازم تبعته حتى لو 0
      'img': img,
      'title': title,
      'description': content,
      'newsDetails': newsDetails
          ?.map((e) => {
        'type': e.type,
        'content': e.content,
      })
          .toList(),
    };
  }
}

class NewsDetailModel {
  final int? id;
  final int? newsId;
  final int? type; // 0 = نص، 1 = صورة
  final String? content;

  const NewsDetailModel({
    this.id,
    this.newsId,
    this.type,
    this.content,
  });

  factory NewsDetailModel.fromJson(Map<String, dynamic> json) {
    return NewsDetailModel(
      id: json['id'],
      newsId: json['newsId'],
      type: json['type'],
      content: json['content'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'newsId': newsId,
      'type': type,
      'content': content,
    };
  }
}
