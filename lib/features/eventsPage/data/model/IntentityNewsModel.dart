class NewsArticleModel {
  final int langId;
  final String img;
  final String title;
  final String description;
  final List<NewsDetailModel> newsDetails;

  NewsArticleModel({
    required this.langId,
    required this.img,
    required this.title,
    required this.description,
    required this.newsDetails,
  });

  // Factory constructor to create an instance from JSON
  factory NewsArticleModel.fromJson(Map<String, dynamic> json) {
    return NewsArticleModel(
      langId: json['langId'],
      img: json['img'],
      title: json['title'],
      description: json['description'],
      newsDetails: (json['newsDetails'] as List)
          .map((detail) => NewsDetailModel.fromJson(detail))
          .toList(),
    );
  }

  // Convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'langId': langId,
      'img': img,
      'title': title,
      'description': description,
      'newsDetails': newsDetails.map((detail) => detail.toJson()).toList(),
    };
  }
}

class NewsDetailModel {
  final int newsId;
  final int type;
  final String content;

  NewsDetailModel({
    required this.newsId,
    required this.type,
    required this.content,
  });

  // Factory constructor to create an instance from JSON
  factory NewsDetailModel.fromJson(Map<String, dynamic> json) {
    return NewsDetailModel(
      newsId: json['newsId']??0,
      type: json['type']??0,
      content: json['content']??"",
    );
  }

  // Convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'newsId': newsId,
      'type': type,
      'content': content,
    };
  }
}
List<Map<String, dynamic>> detailsToJsonList(List<NewsDetailModel> events) {
  return events.map((event) => event.toJson()).toList();
}