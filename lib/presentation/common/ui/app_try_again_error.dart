import 'package:fino/presentation/common/resources/colors/app_colors.dart';
import 'package:flutter/material.dart';

class AppTryAgainError extends StatelessWidget {
  final String message;
  final VoidCallback onTryAgain;
  final EdgeInsets? padding;
  final String? buttonLabel;
  final Color? backgroundColor;

  const AppTryAgainError({
    required this.message,
    required this.onTryAgain,
    this.padding,
    this.buttonLabel,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? AppColors.background.withOpacity(0.7),
      padding: padding ?? const EdgeInsets.all(24.0),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _MessageText(message: message),
            const SizedBox(height: 16),
            _ActionButton(
              label: buttonLabel ?? 'Try again', // TODO: context.strings.tryAgain,
              onTryAgain: onTryAgain,
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageText extends StatelessWidget {
  final String message;

  const _MessageText({required this.message, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: const TextStyle(
        fontSize: 18,
        color: AppColors.foreground,
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final VoidCallback onTryAgain;

  const _ActionButton({
    required this.label,
    required this.onTryAgain,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(flex: 1, child: SizedBox()),
        Expanded(
            flex: 3,
            child: ElevatedButton(
              onPressed: onTryAgain,
              child: Text(label),
            )),
        const Expanded(flex: 1, child: SizedBox()),
      ],
    );
  }
}
