
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fino/presentation/common/resources/colors/app_colors.dart';
import 'package:flutter/material.dart';


class AppFadeInNetworkImage extends StatelessWidget {
  final String? url;
  final BoxFit fit;
  final Widget? errorImage;

  const AppFadeInNetworkImage({
    required this.url,
    this.fit = BoxFit.cover,
    this.errorImage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) {
      return errorImage ?? const SizedBox();
    }

    return CachedNetworkImage(
      imageUrl: url!,
      placeholder: (_, __) => Container(color: AppColors.inactive),
      errorWidget: (_, __, ___) => errorImage ?? const SizedBox(),
      fit: fit,
      fadeInDuration: const Duration(milliseconds: 300),
    );
  }
}
