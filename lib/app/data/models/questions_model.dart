class Questions {
  int? id;
  String? text;
  String? questionType;
  String? createdDate;
  String? publishDate;
  String? lastModifiedDate;
  List<Choices>? choices;
  QuestionCategory? questionCategory;
  CorrectAnsId? correctAnsId;

  Questions({
    this.id,
    this.text,
    this.questionType,
    this.createdDate,
    this.publishDate,
    this.lastModifiedDate,
    this.choices,
    this.questionCategory,
    this.correctAnsId,
  });

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    questionType = json['questionType'];
    createdDate = json['createdDate'];
    publishDate = json['publishDate'];
    lastModifiedDate = json['lastModifiedDate'];
    if (json['choices'] != null) {
      choices = <Choices>[];
      json['choices'].forEach((v) {
        choices?.add(Choices.fromJson(v));
      });
    }
    questionCategory = json['questionCategory'] != null
        ? QuestionCategory.fromJson(json['questionCategory'])
        : null;
    correctAnsId = json['correctAnsId'] != null
        ? CorrectAnsId.fromJson(json['correctAnsId'])
        : null;
  }
}

class Choices {
  int? id;
  String? text;

  Choices({
    this.id,
    this.text,
  });

  Choices.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
  }
}

class QuestionCategory {
  int? categoryID;
  String? categoryText;

  QuestionCategory({
    this.categoryID,
    this.categoryText,
  });

  QuestionCategory.fromJson(Map<String, dynamic> json) {
    categoryID = json['categoryID'];
    categoryText = json['categoryText'];
  }
}

class CorrectAnsId {
  int? id;
  String? text;

  CorrectAnsId({this.id, this.text});

  CorrectAnsId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
  }
}
