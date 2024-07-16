import 'package:flutter/material.dart';

class FAQs {
  List<FAQ>? faqs;
  String? error;
  bool loading = false;

  FAQs({
    this.faqs,
    this.error,
  });

  FAQs.withError(String errorValue)
      : faqs = [],
        error = errorValue;
  FAQs.loading() : loading = true;

  factory FAQs.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    debugPrint(list.runtimeType.toString());
    List<FAQ> faqsList = list.map((i) => FAQ.fromJson(i)).toList();
    return FAQs(faqs: faqsList);
  }
}

class FAQ {
  final int? id;
  final String? question;
  final String? answer;
  final String? createdDate;
  final String? lastModifiedDate;
  final String? error;

  FAQ({
    this.id = -1,
    this.createdDate = "",
    this.lastModifiedDate = "",
    this.question = "",
    this.answer = "",
    this.error,
  });

  FAQ.withError(String errorValue)
      : id = null,
        createdDate = null,
        lastModifiedDate = null,
        question = null,
        answer = null,
        error = errorValue;

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
      id: json['id'],
      question: json['question'],
      answer: json['answer'],
      createdDate: json['createdDate'],
      lastModifiedDate: json['lastModifiedDate'],
    );
  }
}
