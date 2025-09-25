class HomeModel {
  HomeModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.titlePartner,
    required this.titleProgram,
    required this.langId,
    required this.img1,
    required this.img2,
    required this.img3,
    required this.videoTitle,
    required this.videoImage,
    required this.videoPath,
    required this.mapLink,
  });
  late final int id;
  late final String title;
  late final String subTitle;
  late final String titlePartner;
  late final String titleProgram;
  late final int langId;
  late final String img1;
  late final String img2;
  late final String img3;
  late final String videoTitle;
  late final String videoImage;
  late final String videoPath;
  late final String mapLink;

  HomeModel.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    subTitle = json['subTitle'];
    titlePartner = json['titlePartner'];
    titleProgram = json['titleProgram'];
    langId = json['langId'];
    img1 = json['img1'];
    img2 = json['img2'];
    img3 = json['img3'];
    videoTitle = json['videoTitle'];
    videoImage = json['videoImage'];
    videoPath = json['videoPath'];
    mapLink = json['mapLink'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['subTitle'] = subTitle;
    _data['titlePartner'] = titlePartner;
    _data['titleProgram'] = titleProgram;
    _data['langId'] = langId;
    _data['img1'] = img1;
    _data['img2'] = img2;
    _data['img3'] = img3;
    _data['videoTitle'] = videoTitle;
    _data['videoImage'] = videoImage;
    _data['videoPath'] = videoPath;
    _data['mapLink'] = mapLink;
    return _data;
  }
}