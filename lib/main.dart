import 'package:bloc_app/app_route.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BreakingBadApp(
    appRoute: AppRoute(),
  ));
}

class BreakingBadApp extends StatelessWidget {
  final AppRoute appRoute;
  const BreakingBadApp({Key? key, required this.appRoute}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRoute.generateRoute,
    );
  }
}
