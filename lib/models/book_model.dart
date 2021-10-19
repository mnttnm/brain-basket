// To parse this JSON data, do
//
//     final book = bookFromJson(jsonString);

import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

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
        title: json["title"],
        images: Images.fromJson(json["images"]),
        authors: List<String>.from(json["authors"].map((x) => x)),
        price: json["price"],
        description: json["description"],
        details: Details.fromJson(json["details"]),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
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
    this.dimensions,
    this.weight,
    this.shipping,
    this.publication,
    required this.isbn,
    this.ratings,
  });

  final String? dimensions;
  final String? weight;
  final String? shipping;
  final String? publication;
  final String isbn;
  final String? ratings;

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        dimensions: json["dimensions"],
        weight: json["weight"],
        shipping: json["shipping"],
        publication: json["publication"],
        isbn: json["isbn"],
        ratings: json["ratings"],
      );

  Map<String, dynamic> toJson() => {
        "dimensions": dimensions,
        "weight": weight,
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
        front: json["front"],
        back: json["back"],
        others: json["others"],
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
    required this.link,
  });

  final String name;
  final String review;
  final int rating;
  final String link;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        name: json["name"],
        review: json["review"],
        rating: json["rating"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "rating": rating,
        "link": link,
      };
}
