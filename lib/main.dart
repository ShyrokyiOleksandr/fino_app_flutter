import 'package:fino/presentation/app/fino_app.dart';
import 'package:fino/service_locator/app_service_locator.dart';
import 'package:flutter/material.dart';

// TODO: ... ADD WHAT ELSE
// TODO: !Finish: Release to PlayMarket

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppServiceLocator.setup();
  runApp(const FinoApp());
}
