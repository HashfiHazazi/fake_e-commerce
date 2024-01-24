import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter_widget/pages/detail_page.dart';
import 'package:learn_flutter_widget/pages/error/not_found_page.dart';
import 'package:learn_flutter_widget/pages/home_page.dart';
import 'package:learn_flutter_widget/view_models/bloc/product_cubit/product_cubit.dart';

final ProductCubit myProductCubit = ProductCubit()..fetchProduct();

class MyRouters {
  Route onRoute(RouteSettings routePages) { 
    switch (routePages.name) {
      case '/homePage':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: myProductCubit,
            child: const HomePage(),
          ),
        );
      case '/detailPage':
        final args = routePages.arguments as Map<String, dynamic>;
        final productId = args['id'] as int;
        return MaterialPageRoute(
          builder: (context) => DetailPage(id: productId,)
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const NotFoundPage(),
        );
    }
  }
}
