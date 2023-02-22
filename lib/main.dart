import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/presentation/app_widget.dart';

Future<void> main() async {
  await dotenv.load(fileName: '.env');
  runApp(AppWidget());
}
