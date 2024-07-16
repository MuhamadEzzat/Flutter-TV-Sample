import 'package:get/get_utils/src/extensions/internacionalization.dart';

import '../../core/values/localization/local_keys.dart';

class Activity {
  String? name, createdDate, publishDate, lastModifiedDate, error;
  int? id;
  List<Question>? questions;
  Evaluation? evaluationCategory;

  Activity({
    this.name,
    this.createdDate,
    this.publishDate,
    this.lastModifiedDate,
    this.id,
    this.questions,
    this.evaluationCategory,
    this.error,
  });

  Activity.withError(String errorValue)
      : name = "",
        createdDate = "",
        publishDate = "",
        lastModifiedDate = "",
        id = -1,
        questions = [],
        error = errorValue;

  Activity.fromJson(Map<String, dynamic> json) {
    List<dynamic>? evaluationMap = json["evaluationCategory"];
    name = json['name'];
    evaluationCategory = Evaluation.fromJson(evaluationMap != null &&
            evaluationMap.isNotEmpty &&
            evaluationMap[0] != null
        ? evaluationMap[0]
        : null);
    createdDate = json['createdDate'];
    publishDate = json['publishDate'];
    lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
    questions = (json['questions'] as List<dynamic>?) != null
        ? (json['questions'] as List).map((i) => Question.fromJson(i)).toList()
        : null;
  }
}

class Evaluation {
  EvaluationGrade? excellent;
  EvaluationGrade? good;
  EvaluationGrade? bad;

  Evaluation(
    this.excellent,
    this.good,
    this.bad,
  );

  Evaluation.fromJson(Map<String, dynamic>? json) {
    excellent =
        EvaluationGrade.fromJson(json != null ? json["excellent"] : null);
    good = EvaluationGrade.fromJson(json != null ? json["good"] : null);
    bad = EvaluationGrade.fromJson(json != null ? json["bad"] : null);
  }
}

class EvaluationGrade {
  String? uploadedFile;
  String? articleUrl;
  String? recommendation = LocalKeys.kNoRecommendations.tr;

  EvaluationGrade(
    this.uploadedFile,
    this.articleUrl,
    this.recommendation,
  );

  EvaluationGrade.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    articleUrl = json['articleUrl'];
    uploadedFile = json['uploadedFile'];
    recommendation = json['recommendation'];
  }
}

class Question {
  String? text,
      questionType,
      createdDate,
      publishDate,
      lastModifiedDate,
      voiceUrl;
  int? id;
  Choice? correctAnsId;
  List<Choice>? choices;
  QuestionCategory? questionCategory;

  Question({
    this.text,
    this.questionType,
    this.createdDate,
    this.publishDate,
    this.lastModifiedDate,
    this.id,
    this.correctAnsId,
    this.choices,
    this.voiceUrl,
  });

  Question.fromJson(Map<String, dynamic> json) {
    String? voice = json['voice'];
    text = json['text'];
    questionType = json['questionType'];
    createdDate = json['createdDate'];
    publishDate = json['publishDate'];
    lastModifiedDate = json['lastModifiedDate'];
    id = json['id'];
    voiceUrl = voice?.replaceAll(" ", "%20");
    questionCategory = json['questionCategory'] != null
        ? QuestionCategory.fromJson(json['questionCategory'])
        : null;
    correctAnsId = json['correctAnsId'] != null
        ? Choice.fromJson(json['correctAnsId'])
        : null;
    choices = (json['choices'] as List?) != null
        ? (json['choices'] as List).map((i) => Choice.fromJson(i)).toList()
        : null;
  }
}

class QuestionCategory {
  String? text;
  int? id;

  QuestionCategory({
    this.text,
    this.id,
  });

  QuestionCategory.fromJson(Map<String, dynamic> json) {
    text = json['categoryText'];
    id = json['categoryID'];
  }
}

class Choice {
  String? text;
  int? id;
  String? voiceUrl;
  bool isChecked = false;

  Choice({
    this.text,
    this.id,
    this.voiceUrl,
  });

  Choice.fromJson(Map<String, dynamic> json) {
    String? voice = json['voice'];
    text = json['text'];
    id = json['id'];
    voiceUrl = voice?.replaceAll(" ", "%20");
  }
}
