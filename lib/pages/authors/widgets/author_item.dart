import 'package:flutter/material.dart';
import 'package:rs_books/helpers/my_flutter_app_icons.dart';
import 'package:rs_books/models/author_model.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthorItem extends StatelessWidget {
  final String name;
  final String image;
  final String authorDetails;
  final double containerWidth;
  final SocialLinks? socialLinks;
  AuthorItem({
    Key? key,
    required this.image,
    required this.authorDetails,
    required this.name,
    required this.containerWidth,
    this.socialLinks,
  }) : super(key: key);

  final Map<String, dynamic> iconMap = {
    "facebook": {
      'icon_data': SocialIcons.facebook,
      'color': Colors.pinkAccent.shade400
    },
    "telegram": {
      'icon_data': SocialIcons.telegram,
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
      children: [
        Image.asset(
          image,
          width: 300,
          height: 310,
          fit: BoxFit.fill,
        ),
        VSpace.sm,
        Text(
          name,
          style: TextStyles.h3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: socialLinks!
              .toJson()
              .entries
              .map(
                (e) => IconButton(
                  onPressed: () async {
                    if (await canLaunch(e.value! as String)) {
                      await launch(e.value as String);
                    } else {
                      throw 'Could not launch ${e.value}';
                    }
                  },
                  icon: Icon(
                    iconMap[e.key]!['icon_data'] as IconData,
                    color: iconMap[e.key]!['color'] as Color,
                  ),
                ),
              )
              .toList(),
        ),
        Container(
          width: containerWidth,
          padding: EdgeInsets.all(Insets.xl),
          child: Text(
            authorDetails,
            style: TextStyles.body16.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }
}
