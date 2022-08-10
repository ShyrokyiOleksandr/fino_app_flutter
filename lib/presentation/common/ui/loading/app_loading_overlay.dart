import 'package:fino/presentation/common/resources/colors/app_colors.dart';
import 'package:fino/presentation/common/ui/loading/app_loading_indicator.dart';
import 'package:flutter/material.dart';


class AppLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Duration visibilityChangeDuration;
  final Color? indicatorColor;
  final Color? backgroundColor;

  const AppLoadingOverlay({
    this.isLoading = true,
    this.visibilityChangeDuration = Duration.zero,
    this.indicatorColor,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isLoading,
      child: AnimatedOpacity(
        duration: visibilityChangeDuration,
        opacity: isLoading ? 1 : 0,
        child: Container(
          color: backgroundColor ?? AppColors.background.withOpacity(0.7),
          alignment: Alignment.center,
          child: SafeArea(
            child: AppLoadingIndicator(indicatorColor: indicatorColor),
          ),
        ),
      ),
    );
  }
}
