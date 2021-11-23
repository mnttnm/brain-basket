// To parse this JSON data, do
//
//     final author = authorFromJson(jsonString);

import 'dart:convert';

Author authorFromJson(String str) =>
    Author.fromJson(json.decode(str) as Map<String, dynamic>);

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
        name: json["name"] as String,
        shortName: json["short_name"] as String,
        about: json["about"] as String,
        socialLinks:
            SocialLinks.fromJson(json["social_links"] as Map<String, dynamic>),
        experience: json["experience"] as int,
        institutes:
            List<String>.from(json["institutes"] as List<dynamic>),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "short_name": shortName,
        "about": about,
        "social_links": socialLinks != null ? socialLinks!.toJson() : {},
        "experience": experience,
        "institutes": institutes != null ? List<dynamic>.from(institutes!) : [],
      };
}

class SocialLinks {
  SocialLinks({
    required this.facebook,
    required this.telegram,
    required this.instagram,
  });

  final String facebook;
  final String telegram;
  final String instagram;

  factory SocialLinks.fromJson(Map<String, dynamic> json) => SocialLinks(
        facebook: json["facebook"] as String,
        telegram: json["telegram"] as String,
        instagram: json["instagram"] as String,
      );

  Map<String, dynamic> toJson() => {
        "facebook": facebook,
        "telegram": telegram,
        "instagram": instagram,
      };
}
