import 'package:flutter/material.dart';
import 'package:github_test_app/di/dependencies.dart';
import 'common/bootstrap.dart';

void main() async {
  await initDependencies();
  runApp(const Bootstrap());
}
