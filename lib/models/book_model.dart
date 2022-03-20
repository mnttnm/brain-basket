// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) =>
    Book.fromJson(json.decode(str) as Map<String, dynamic>);

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
  Book({
    required this.title,
    required this.images,
    required this.authors,
    required this.price,
    required this.description,
    required this.details,
    this.reviews,
  });

  final String title;
  final Images images;
  final List<String> authors;
  final int price;
  final String description;
  final Details details;
  final List<Review>? reviews;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        title: json["title"] as String,
        images: Images.fromJson(json["images"] as Map<String, dynamic>),
        authors:
            List<String>.from((json["authors"] as List<dynamic>).map((x) => x)),
        price: json["price"] as int,
        description: json["description"] as String,
        details: Details.fromJson(json["details"] as Map<String, dynamic>),
        reviews:
            List<Review>.from(
          (json["reviews"] as List<dynamic>)
              .map((x) => Review.fromJson(x as Map<String, dynamic>)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "images": images.toJson(),
        "authors": List<dynamic>.from(authors.map((x) => x)),
        "price": price,
        "description": description,
        "details": details.toJson(),
        "reviews": reviews != null ? List<dynamic>.from(reviews!.map((x) => x.toJson())) : [],
      };
}

class Details {
  Details({
    this.pages,
    this.language,
    this.shipping,
    this.publication,
    required this.isbn,
    this.ratings,
  });

  final String? pages;
  final String? language;
  final String? shipping;
  final String? publication;
  final String isbn;
  final String? ratings;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        pages: json["pages"] as String,
        language: json["language"] as String,
        shipping: json["shipping"] as String,
        publication: json["publication"] as String,
        isbn: json["isbn"] as String,
        ratings: json["ratings"] as String, 
      );

  Map<String, dynamic> toJson() => {
        "pages": pages,
        "language": language,
        "shipping": shipping,
        "publication": publication,
        "isbn": isbn,
        "ratings": ratings,
      };
}

class Images {
  Images({
    required this.front,
    required this.back,
    required this.others,
  });

  final String front;
  final String back;
  final String others;

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        front: json["front"] as String,
        back: json["back"] as String,
        others: json["others"] as String,
      );

  Map<String, dynamic> toJson() => {
        "front": front,
        "back": back,
        "others": others,
      };
}

class Review {
  Review({
    required this.name,
    required this.review,
    required this.rating,
      this.link
  });

  final String name;
  final String review;
  final int rating;
  final String? link;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        name: json["name"] as String,
        review: json["review"] as String,
        rating: json["rating"] as int,
        link: json["link"] != null ? json["link"] as String : '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "rating": rating,
        "link": link,
      };
}
