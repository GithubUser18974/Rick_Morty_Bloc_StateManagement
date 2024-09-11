import 'package:flutter/material.dart';
import 'package:untitled4/app_routes.dart';

void main() {
  runApp(MyApp(AppRoutes()));
}

class MyApp extends StatelessWidget {
  final AppRoutes appRouter;
  MyApp(this.appRouter);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
