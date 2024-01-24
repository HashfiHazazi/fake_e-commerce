import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:learn_flutter_widget/models/product_model.dart';
import 'package:http/http.dart' as http;

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());
  final String baseUrl = 'https://dummyjson.com';

  void fetchProduct() async {
    emit(ProductLoading());

    await Future.delayed(
      const Duration(seconds: 3),
    );

    try {
      final productResponse =
          await http.get(Uri.parse('$baseUrl/products?limit=100'));
      final productBody = productResponse.body;
      final productResult = jsonDecode(productBody);
      List<ProductModel> productList = List.from(
        productResult['products'].map(
          (products) => ProductModel.fromJson(products),
        ),
      );
      emit(ProductLoaded(productResult: productList));
    } catch (e) {
      emit(ProductError());
    }
  }
}
