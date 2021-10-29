import 'package:flutter/material.dart';
import 'package:rs_books/helpers/my_flutter_app_icons.dart';
import 'package:rs_books/models/author_model.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthorItem extends StatelessWidget {
  final String name;
  final String image;
  final String authorDetails;
  final double containerWidth;
  final SocialLinks? socialLinks;
  AuthorItem(
      {Key? key,
      required this.image,
      required this.authorDetails,
      required this.name,
      required this.containerWidth,
      this.socialLinks})
      : super(key: key);

  final Map<String, dynamic> iconMap = {
    "facebook": {
      'icon_data': SocialIcons.facebook_f,
      'color': Colors.pinkAccent.shade400
    },
    "telegram": {
      'icon_data': SocialIcons.telegram_plane,
      'color': Colors.blueAccent.shade400
    },
    "instagram": {
      'icon_data': SocialIcons.instagram,
      'color': Colors.purpleAccent.shade400
    }
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 80,
        ),
        Image.asset(
          image,
          width: 300,
          height: 310,
          fit: BoxFit.fill,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: socialLinks!
                .toJson()
                .entries
                .map((e) => IconButton(
                    onPressed: () async {
                      if (await canLaunch(e.value!)) {
                        await launch(e.value);
                      } else {
                        throw 'Could not launch ${e.value}';
                      }
                    },
                    icon: Icon(
                      iconMap[e.key]!['icon_data'],
                      color: iconMap[e.key]!['color'],
                    )))
                .toList()),
        Container(
            width: 600,
            height: 400,
            padding: EdgeInsets.all(40.0),
            child: Text(
              authorDetails,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  wordSpacing: 5,
                  height: 1.5),
            )),
      ],
    );
  }
}
