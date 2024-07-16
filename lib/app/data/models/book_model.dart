import 'dart:convert';

import 'package:get/get.dart';

import 'marker.dart';

class Books {
  Books({
    required this.books,
  });

  List<Book> books;
  String? errorString;

  factory Books.fromJson(Map<String, dynamic> json) => Books(
        books: List<Book>.from(json["results"].map((x) => Book.fromJson(x))),
      );

  Books.withError(String errorValue)
      : books = [],
        errorString = errorValue;
}

class Book {
  Book({
    required this.id,
    required this.status,
    required this.name,
    required this.description,
    required this.image,
    required this.isFree,
    required this.voice,
    required this.bookVoice,
    required this.bookMarker,
    required this.bookPages,
    required this.bookPuzzle,
    required this.bookPaintingGame,
    required this.bookDragDrop,
    this.errorString,
  });

  int id;
  String status;
  String name;
  String description;
  String image;
  bool isFree;
  String? voice;
  String? bookVoice;
  List<Marker> bookMarker;
  List<BookPage> bookPages;
  List bookPuzzle;
  List bookPaintingGame;
  List bookDragDrop;
  String? errorString;

  factory Book.fromJson(Map<String, dynamic> jsonObject) {
    final data = json.decode(jsonObject["bookMarker"]);
    List<Marker> _markers = [];
    try {
      for (var e in (data as List)) {
        _markers.add(Marker.fromJson(e));
      }
    } catch (e) {
      _markers = [];
    }
    bool isAr = Get.locale?.languageCode == "ar";

    return Book(
      id: jsonObject["id"],
      status: jsonObject["status"],
      name: isAr ? jsonObject["name"] : jsonObject["nameInEnglish"] ?? "",
      description: isAr
          ? jsonObject["description"]
          : jsonObject["descriptionInEnglish"] ?? "",
      image: jsonObject["image"],
      isFree: jsonObject["isFree"] == 1,
      voice: jsonObject["voice"],
      bookVoice: jsonObject["bookVoice"],
      bookMarker: _markers..sort((a, b) => a.start.compareTo(b.start)),
      bookPages: (jsonObject.containsKey("bookPages") &&
              jsonObject["bookPages"]!.isNotEmpty)
          ? List<BookPage>.from(
              jsonObject["bookPages"].map((x) => BookPage.fromJson(x)))
          : [],
      bookPuzzle: (jsonObject.containsKey("bookPuzzel") &&
              jsonObject["bookPuzzel"]!.isNotEmpty)
          ? List.from(jsonObject["bookPuzzel"].map((x) => x))
          : [],
      bookPaintingGame: (jsonObject.containsKey("bookPaintingGame") &&
              jsonObject["bookPaintingGame"]!.isNotEmpty)
          ? List.from(jsonObject["bookPaintingGame"].map((x) => x))
          : [],
      bookDragDrop: (jsonObject.containsKey("bookDragDrop") &&
              jsonObject["bookDragDrop"]!.isNotEmpty)
          ? List.from(jsonObject["bookDragDrop"].map((x) => x))
          : [],
    );
  }

  Book.withError(String errorValue)
      : id = -1,
        status = "",
        name = "",
        description = "",
        image = "",
        isFree = true,
        voice = "",
        bookVoice = "",
        bookMarker = [],
        bookPages = [],
        bookPuzzle = [],
        bookPaintingGame = [],
        bookDragDrop = [],
        errorString = errorValue;
}

class BookPage {
  BookPage({
    required this.id,
    required this.text,
    required this.image,
  });

  int id;
  String text;
  String image;

  factory BookPage.fromJson(Map<String, dynamic> json) => BookPage(
        id: json["id"],
        text: json["text"],
        image: json["image"],
      );
}
