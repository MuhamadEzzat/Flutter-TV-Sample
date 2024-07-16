import 'package:flutter/material.dart';

class Blogs {
  final List<Blog>? blogs;
  final String? error;

  Blogs({
    this.blogs,
    this.error,
  });

  Blogs.withError(String errorValue)
      : blogs = [],
        error = errorValue;

  factory Blogs.fromJson(Map<String, dynamic> parsedJson) {
    var list = parsedJson['results'] as List;
    debugPrint(list.runtimeType.toString());
    List<Blog> blogsList = list.map((i) => Blog.fromJson(i)).toList();
    return Blogs(blogs: blogsList);
  }
}

class NestedBlogs {
  List<NestedBlogCategory> categories = [];
  String? error;
  bool loading = false;

  NestedBlogs({
    this.categories = const [],
    this.error,
  });

  NestedBlogs.loading() : loading = true;
}

class Blog {
  int? id;
  String? title;
  String? status;
  String? description;
  String? image;
  String? blogHtml;
  String? createDate;
  String? lastModifiedDate;
  BlogCategory? blogCategory;

  Blog({
    this.id,
    this.title,
    this.status,
    this.description,
    this.image,
    this.blogHtml,
    this.createDate,
    this.lastModifiedDate,
    this.blogCategory,
  });

  Blog.fromJson(Map<String, dynamic> json) {
    if (json["blogCategoryId"] != null) {
      blogCategory = BlogCategory.fromJson(json["blogCategoryId"]);
    } else {
      blogCategory = null;
    }
    id = json['id'];
    title = json['title'];
    status = json['status'];
    description = json['description'];
    image = json['image'];
    blogHtml = json['blog_html'];
    createDate = json['createdDate'];
    lastModifiedDate = json['lastModifiedDate'];
    blogCategory = blogCategory;
  }
}

// ignore: must_be_immutable
class BlogCategory {
  int? id;
  String? categoryText;

  BlogCategory({this.id, this.categoryText});

  BlogCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryText = json['categoryText'];
  }

  @override
  List<Object?> get props => [id, categoryText];
}

// ignore: must_be_immutable
class NestedBlogCategory extends BlogCategory {
  List<Blog>? articles = [];

  NestedBlogCategory({this.articles, int? id, String? categoryText})
      : super(id: id, categoryText: categoryText);
}

/*
{
    "id": 13,
            "title": "testing",
            "status": "DEFAULT",
            "description": "hellp",
            "image": "https://newgenereactjstest.s3.amazonaws.com/259019465a687f35a28f47c2269d8ec3.jpg",
            "blog_html": "PHA+YmxhY2s8L3A+Cg==",
            "createdDate": "2019-06-17 11:38",
            "publishDate": "2019-06-17 11:37",
            "lastModifiedDate": "2019-06-17T11:38:58.000+0200",
            "blogCategoryId": {
                "id": 1,
                "categoryText": "تربوي"
            }
}*/
