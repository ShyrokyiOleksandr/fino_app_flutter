import 'dart:math';

import 'package:fino/presentation/common/extensions/build_context_extensions.dart';
import 'package:fino/presentation/common/resources/colors/app_colors.dart';
import 'package:fino/presentation/common/ui/bottom_sheets/app_bottom_sheet_drag_anchor.dart';
import 'package:flutter/material.dart';

class HomeTransactionsDraggableSheet extends StatefulWidget {
  static const double minHeight = 100;

  final Function(double heigthFraction) onSheetHeightChanged;

  const HomeTransactionsDraggableSheet({
    required this.onSheetHeightChanged,
    Key? key,
  }) : super(key: key);

  @override
  State<HomeTransactionsDraggableSheet> createState() => _HomeTransactionsDraggableSheetState();
}

class _HomeTransactionsDraggableSheetState extends State<HomeTransactionsDraggableSheet> {
  final DraggableScrollableController _draggableScrollableController = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        /// Convert actual heigth to a 0..1 range, since it's used by DraggableScrollableSheet:
        final _sheetChildMinSize = HomeTransactionsDraggableSheet.minHeight / constraints.maxHeight;
        return DraggableScrollableSheet(
          snap: true,
          expand: true,
          controller: _draggableScrollableController,
          initialChildSize: _sheetChildMinSize,
          minChildSize: _sheetChildMinSize,
          builder: (context, scrollController) {
            final _currentHeightFraction =
                _calculateCurrentSheetHeightFraction(sheetMinSizeFraction: _sheetChildMinSize);
            _notifyHeightChange(heightFraction: _currentHeightFraction);
            return _SheetContainer(
              /// Make corners sharp as more the sheet is opened
              radius: 24 * (1 - _currentHeightFraction),
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                controller: scrollController,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const AppBottomSheetDragAnchor(),
                    Stack(
                      children: [
                        _CollapsedContentContainer(
                          maxSheetHeight: constraints.maxHeight,
                          currentSheetHeightFraction: _currentHeightFraction,
                          child: const _CollapsedContent(),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  double _calculateCurrentSheetHeightFraction({required final double sheetMinSizeFraction}) {
    return (_draggableScrollableController.size - sheetMinSizeFraction) / (1 - sheetMinSizeFraction);
  }

  void _notifyHeightChange({required final double heightFraction}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onSheetHeightChanged(heightFraction);
    });
  }
}

class _SheetContainer extends StatelessWidget {
  final Widget child;
  final double radius;

  const _SheetContainer({
    required this.child,
    required this.radius,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(radius),
          topLeft: Radius.circular(radius),
        ),
      ),
      child: child,
    );
  }
}

/// Represents a container for current sheet collapsed content. Implements offset and opacity transformations
class _CollapsedContentContainer extends StatelessWidget {
  final double maxSheetHeight;
  final double currentSheetHeightFraction;
  final Widget child;

  const _CollapsedContentContainer({
    required this.maxSheetHeight,
    required this.currentSheetHeightFraction,
    required this.child,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: _calculateCollapsedContentOpacityForHeightFraction(
          heightFraction: currentSheetHeightFraction,
        ),
        child: Padding(
          padding: _calculateCollapsedContentPaddingForHeightFraction(
            maxHeight: maxSheetHeight,
            heightFraction: currentSheetHeightFraction,
          ),
        ));
  }

  /// Calculates content opacity for current sheet position, also adding a curve for a non-linear transformation
  double _calculateCollapsedContentOpacityForHeightFraction({required final double heightFraction}) {
    return pow(1 - heightFraction, 10).toDouble();
  }

  /// Calculates the top padding the content for current sheet position for the slide in/out effect
  EdgeInsets _calculateCollapsedContentPaddingForHeightFraction({
    required final double maxHeight,
    required final double heightFraction,
  }) {
    return EdgeInsets.only(top: maxHeight / 4 * heightFraction);
  }
}

class _CollapsedContent extends StatelessWidget {
  const _CollapsedContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.strings.homeTransactionsListPlaceholder.toUpperCase(),
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: AppColors.inactive,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// TODO: !!!!!! Ended here !!!!!!!