// To parse this JSON data, do
//
//     final author = authorFromJson(jsonString);

import 'dart:convert';

Author authorFromJson(String str) => Author.fromJson(json.decode(str));

String authorToJson(Author data) => json.encode(data.toJson());

class Author {
  Author({
    required this.name,
    this.shortName,
    required this.about,
    this.socialLinks,
    required this.experience,
    this.institutes,
  });

  final String name;
  final String? shortName;
  final String about;
  final SocialLinks? socialLinks;
  final int experience;
  final List<String>? institutes;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json["name"],
        shortName: json["short_name"],
        about: json["about"],
        socialLinks: SocialLinks.fromJson(json["social_links"]),
        experience: json["experience"],
        institutes: List<String>.from(json["institutes"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "short_name": shortName,
        "about": about,
        "social_links": socialLinks != null ? socialLinks!.toJson() : {},
        "experience": experience,
        "institutes": institutes != null ?  List<dynamic>.from(institutes!.map((x) => x)): [],
      };
}

class SocialLinks {
  SocialLinks({
    required this.facebook,
    required this.twitter,
    required this.instagram,
  });

  final String facebook;
  final String twitter;
  final String instagram;

  factory SocialLinks.fromJson(Map<String, dynamic> json) => SocialLinks(
        facebook: json["facebook"],
        twitter: json["twitter"],
        instagram: json["instagram"],
      );

  Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "twitter": twitter,
        "instagram": instagram,
      };
}
