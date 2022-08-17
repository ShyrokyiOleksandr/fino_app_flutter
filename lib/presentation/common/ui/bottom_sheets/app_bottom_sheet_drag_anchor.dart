import 'package:flutter/material.dart';

class AppBottomSheetDragAnchor extends StatelessWidget {
  const AppBottomSheetDragAnchor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        width: MediaQuery.of(context).size.width / 10,
        height: 5,
        margin: const EdgeInsets.only(top: 8, bottom: 10),
        decoration: const BoxDecoration(
          borderRadius:  BorderRadius.all(Radius.circular(2)),
          color:  Color(0xFFEBEBEB),
        ),
      ),
    );
  }
}