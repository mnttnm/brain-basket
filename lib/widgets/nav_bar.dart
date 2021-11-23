import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/constants/controllers.dart';
import 'package:rs_books/helpers/responsiveness.dart';
import 'package:rs_books/routing/routes.dart';
import 'package:rs_books/styled_widgets/styled_spacers.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/themes.dart';
import 'package:rs_books/widgets/horizontal_menu_items.dart';

class _NavBarItem extends StatefulWidget {
  final String? title;
  final bool? isPrimary;

  const _NavBarItem({Key? key, this.title, this.isPrimary = false})
      : super(key: key);

  @override
  __NavBarItemState createState() => __NavBarItemState();
}

class __NavBarItemState extends State<_NavBarItem> {
  Color? elementColor;
  Color? boxColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        menuController.changeActiveItemTo(widget.title!);
        context.goNamed(widget.title!);
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
        padding: const EdgeInsets.only(
          top: 10,
          bottom: 10,
          left: 15,
          right: 15,
        ),
        decoration: BoxDecoration(
            color: boxColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(5),
            ),
        ),
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
              icon: const Icon(Icons.menu),
            ),
      elevation: 0,
      title: const NavBar(),
      iconTheme: const IconThemeData(
        color: Colors.white,
      ),
    );

class NavBar extends StatelessWidget {
  const NavBar({
    Key? key,
  }) : super(key: key);

  void _onTap(BuildContext context, String itemName) {
    menuController.changeActiveItemTo(itemName);
    GoRouter.of(context).goNamed(itemName);
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!ResponsiveWidget.isSmallScreen(context)) ...[
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(Insets.sm),
                child: Image.asset(
                  'assets/logo/bb-bw.jpeg',
                  width: 48,
                  height: 48,
                  color: theme.accent1,
                  colorBlendMode: BlendMode.colorDodge,
                ),
              ),
              HSpace(Insets.sm),
              RichText(
                  text: TextSpan(
                text: "Brain Basket",
                style: const TextStyle(color: Colors.white, fontSize: 18),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => _onTap(context, BooksPageRoute),
              ),
              ),
            ],
          ),
          const Spacer(),
          HorizontalMenuItem(
            itemName: BooksPageRoute,
            onTap: () => _onTap(context, BooksPageRoute),
          ),
          HorizontalMenuItem(
            itemName: AuthorsPageRoute,
            onTap: () => _onTap(context, AuthorsPageRoute),
          ),
          HorizontalMenuItem(
            itemName: ContactPageRoute,
            onTap: () => _onTap(context, ContactPageRoute),
          ),
        ],
        const Spacer(),
        HorizontalMenuItem(
          itemName: CartPageRoute,
          onTap: () => _onTap(context, CartPageRoute),
        ),
      ],
    );
  }
}
