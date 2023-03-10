import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'core/presentation/app_widget.dart';

void main() async {
  runApp(ProviderScope(child: AppWidget()));
}
