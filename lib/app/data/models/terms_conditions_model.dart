import 'package:flutter/foundation.dart';

class TermsConditions {
  final List<TermCondition>? termsConditions;
  final String? error;

  TermsConditions({this.termsConditions, this.error});

  TermsConditions.withError(String errorValue)
      : termsConditions = [],
        error = errorValue;

  factory TermsConditions.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    debugPrint(list.runtimeType.toString());
    List<TermCondition> termsList =
        list.map((i) => TermCondition.fromJson(i)).toList();
    return TermsConditions(termsConditions: termsList);
  }
}

class TermCondition {
  final int? id;
  final String? title;
  final String? text;
  final String? createdDate;
  final String? lastModifiedDate;
  final String? error;

  TermCondition(
      {this.id = -1,
      this.createdDate = "",
      this.lastModifiedDate = "",
      this.title = "",
      this.text = "",
      this.error});

  TermCondition.withError(String errorValue)
      : this.id = null,
        this.createdDate = null,
        this.lastModifiedDate = null,
        this.title = null,
        this.text = null,
        error = errorValue;

  factory TermCondition.fromJson(Map<String, dynamic> json) {
    return TermCondition(
      id: json['id'],
      title: json['title'],
      text: json['text'],
      createdDate: json['createdDate'],
      lastModifiedDate: json['lastModifiedDate'],
    );
  }
}
