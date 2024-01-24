import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter_widget/pages/home_page.dart';
import 'package:learn_flutter_widget/pages/routes/my_route.dart';
import 'package:learn_flutter_widget/view_models/bloc/theme_cubit/theme_cubit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final route = MyRouters();

  final isDarkMode = false;

  final myThemeCubit = ThemeCubit()..changeTheme();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => myThemeCubit,
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Product E-Commerce',
            theme: state,
            onGenerateRoute: route.onRoute,
            initialRoute: '/homePage',
            home: const HomePage(),
          );
        },
      ),
    );
  }
}
