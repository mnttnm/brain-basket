import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rs_books/styles.dart';
import 'package:rs_books/themes.dart';

/// Accent colored btn (orange), wraps RawBtn
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    this.label,
    this.icon,
    this.child,
    this.cornerRadius,
    this.backgroundColor,
    this.width,
    this.height,
    this.fontSize,
  }) : super(key: key);
  final Widget? child;
  final String? label;
  final IconData? icon;
  final double? cornerRadius;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        minimumSize: Size(
          width ?? 124,
          height ?? 36,
        ),
        primary: backgroundColor ?? theme.accent1,
        onPrimary: theme.inverseTextColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 4.0)),
        ),
      ),
      child: child ??
          Text(
            label!.toUpperCase(),
            style: TextStyle(
              fontSize: fontSize ?? 14,
            ),
          ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    Key? key,
    required this.onPressed,
    this.label,
    this.icon,
    this.child,
    this.cornerRadius,
    this.backgroundColor,
    this.width,
    this.height,
    this.fontSize,
  }) : super(key: key);
  final Widget? child;
  final String? label;
  final IconData? icon;
  final double? cornerRadius;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final double? width;
  final double? height;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    final AppTheme theme = context.watch();
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        // side: const BorderSide(width: 1.5),
        minimumSize: Size(
          width ?? 120,
          height ?? 36,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(cornerRadius ?? 4.0)),
        ),
      ).copyWith(
        side: MaterialStateProperty.resolveWith<BorderSide?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.hovered)) {
              return BorderSide(
                width: 1.5,
                color: backgroundColor ?? theme.accent1,
              );
            }
            return BorderSide(
              color: backgroundColor ?? theme.accent1,
            );
          },
        ),
      ),
      child: child ??
          Text(
            label!.toUpperCase(),
            style: TextStyle(
              fontSize: fontSize ?? 14,
            ),
          ),
    );
  }
}

class Link extends StatelessWidget {
  const Link(
    this.label, {
    Key? key,
    required this.onPressed,
    this.isCompact = false,
    this.style,
    this.showUnderline = false,
  }) : super(key: key);
  final String label;
  final VoidCallback? onPressed;
  final bool isCompact;
  final TextStyle? style;
  final bool showUnderline;

  @override
  Widget build(BuildContext context) {
    final TextStyle finalStyle = style ??
        TextStyles.caption.copyWith(
          decoration:
              showUnderline ? TextDecoration.underline : TextDecoration.none,
          fontWeight: FontWeight.w500,
        );
    return TextButton(
      onPressed: onPressed,
      child: Text(label, style: finalStyle),
    );
  }
}
