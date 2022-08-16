import 'package:fino/presentation/common/resources/colors/app_colors.dart';
import 'package:fino/presentation/common/ui/images/app_fade_in_network_image.dart';
import 'package:flutter/material.dart';

class AppCircleImage extends StatelessWidget {
  final String? imageUrl;
  final double? size;
  final double borderWidth;
  final Color borderColor;
  final Color placeholderColor;

  const AppCircleImage({
    required this.imageUrl,
    this.size,
    this.borderWidth = 0,
    this.borderColor = AppColors.background,
    this.placeholderColor = AppColors.inactive,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: placeholderColor,
        shape: BoxShape.circle,
        border: borderWidth > 0 ? Border.all(color: borderColor, width: borderWidth) : null,
      ),
      child: ClipOval(
        clipBehavior: Clip.antiAlias,
        child: AppFadeInNetworkImage(url: imageUrl),
      ),
    );
  }
}
