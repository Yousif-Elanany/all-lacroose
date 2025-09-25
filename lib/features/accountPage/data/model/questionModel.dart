
class QuestionModel {
  final int? id;
  final int? langId;
  final String? ques;
  final String? answer;

  QuestionModel({
    this.id,
    this.langId,
    this.ques,
    this.answer,
  });

  QuestionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        langId = json['langId'] as int?,
        ques = json['ques'] as String?,
        answer = json['answer'] as String?;

  Map<String, dynamic> toJson() => {
    'id' : id,
    'langId' : langId,
    'ques' : ques,
    'answer' : answer
  };
}