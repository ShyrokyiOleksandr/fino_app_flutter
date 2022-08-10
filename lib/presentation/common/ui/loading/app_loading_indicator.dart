import 'package:fino/presentation/common/resources/colors/app_colors.dart';
import 'package:flutter/material.dart';


class AppLoadingIndicator extends StatelessWidget {
  final Color? indicatorColor;

  const AppLoadingIndicator({
    this.indicatorColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(indicatorColor ?? AppColors.foreground),
    );
  }
}