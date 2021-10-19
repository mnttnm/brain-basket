import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/constants/style.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/widgets/horizontal_menu_items.dart';

class _NavBarItem extends StatefulWidget {
  final String? title;
  final bool? isPrimary;

  _NavBarItem({Key? key, this.title, this.isPrimary = false}) : super(key: key);

  @override
  __NavBarItemState createState() => __NavBarItemState();
}

class __NavBarItemState extends State<_NavBarItem> {
  Color? elementColor;
  Color? boxColor;

  @override
  void initState() {
    super.initState();
    elementColor = secondaryLight;
    // boxColor = widget.isPrimary == true ? Colors.lightBlueAccent : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        menuController.changeActiveItemTo(widget.title!);
        navigationController.navigateTo(widget.title!);
      },
      onHover: (value) {
        setState(() {
          if (widget.isPrimary == true) {
            // boxColor = value ? Colors.green : Colors.lightBlueAccent;
          } else {
            elementColor = value ? Colors.black : Colors.grey.shade500;
          }
        });
      },
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 15,
          right: 15,
        ),
        decoration: BoxDecoration(
            color: boxColor,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Text(
          widget.title!,
          style: TextStyle(color: elementColor, fontSize: 16),
        ),
      ),
    );
  }
}

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? null
          : IconButton(
              onPressed: () {
                key.currentState!.openDrawer();
              },
              icon: Icon(Icons.menu)),
      elevation: 0,
      title: NavBar(),
      iconTheme: IconThemeData(
        color: light,
      ),
    );

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!ResponsiveWidget.isSmallScreen(context)) ...[
          RichText(
              text: TextSpan(
                  text: "Brain Basket",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      print('sdf');
                      menuController.changeActiveItemTo(BooksPageRoute);
                      navigationController.navigateTo(BooksPageRoute);
                    })),
          Spacer(),
          HorizontalMenuItem(
              itemName: BooksPageRoute,
              onTap: () {
                menuController.changeActiveItemTo(BooksPageRoute);
                navigationController.navigateTo(BooksPageRoute);
              }),
          HorizontalMenuItem(
              itemName: AuthorsPageRoute,
              onTap: () {
                menuController.changeActiveItemTo(AuthorsPageRoute);
                navigationController.navigateTo(AuthorsPageRoute);
              }),
          HorizontalMenuItem(
              itemName: ContactPageRoute,
              onTap: () {
                menuController.changeActiveItemTo(ContactPageRoute);
                navigationController.navigateTo(ContactPageRoute);
              }),
        ],
        Spacer(),
        HorizontalMenuItem(
            itemName: CartPageRoute,
            onTap: () {
              menuController.changeActiveItemTo(CartPageRoute);
              navigationController.navigateTo(CartPageRoute);
            }),
      ],
    );
  }
}
