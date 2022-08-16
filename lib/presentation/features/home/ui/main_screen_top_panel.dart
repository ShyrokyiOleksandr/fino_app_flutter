import 'package:fino/presentation/common/resources/assets/app_assets.dart';
import 'package:fino/presentation/common/resources/colors/app_colors.dart';
import 'package:fino/presentation/common/ui/images/app_circle_image.dart';
import 'package:flutter/material.dart';

class MainScreenTopPanel extends StatelessWidget {
  static const double height = 46;
  static const EdgeInsets padding = EdgeInsets.fromLTRB(16, 8, 16, 8);

  final Color backgroundColor;
  //final User? currentUser;
  final VoidCallback onUserPressed;
  final VoidCallback onFilterPressed;

  const MainScreenTopPanel({
    required this.backgroundColor,
    //required this.currentUser,
    required this.onUserPressed,
    required this.onFilterPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor,
      child: SafeArea(
        child: Padding(
          padding: padding,
          child: Row(
            children: [
              _ItemContainer(
                onPressed: onUserPressed,
                child: const AspectRatio(
                  aspectRatio: 1,
                  child: Hero(
                    tag: ValueKey("avatar_icon"),
                    // TODO: Provide user image
                    child: AppCircleImage(
                        imageUrl:
                            "https://d5nunyagcicgy.cloudfront.net/external_assets/hero_examples/hair_beach_v391182663/original.jpeg"),
                  ),
                ),
              ),
              const Spacer(),
              _ItemContainer(
                padding: const EdgeInsets.symmetric(horizontal: 26),
                child: Center(
                  child: Image.asset(AppAssets.icLogoSmall),
                ),
              ),
              const Spacer(),
              _ItemContainer(
                onPressed: onFilterPressed,
                child: Image.asset(AppAssets.icFilter),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final VoidCallback? onPressed;

  const _ItemContainer({
    required this.child,
    this.padding = const EdgeInsets.all(4),
    this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MainScreenTopPanel.height,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: const BorderRadius.all(Radius.circular(MainScreenTopPanel.height / 2)),
        border: Border.all(color: AppColors.inactive, width: 1),
      ),
      child: _ItemInkOverlay(
        onPressed: onPressed,
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

class _ItemInkOverlay extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  const _ItemInkOverlay({
    required this.onPressed,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: const BorderRadius.all(
                Radius.circular(MainScreenTopPanel.height / 2),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
