import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:learn_flutter_widget/models/detail_product_model.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  DetailCubit() : super(DetailInitial());
  final String baseUrl = 'https://dummyjson.com';

  void fetchDetail(int id) async {
    emit(DetailLoading());
    // await Future.delayed(const Duration(seconds: 3));
    try {
      final detailResponse = await http.get(Uri.parse('$baseUrl/products/$id'));
      final detailBody = detailResponse.body;
      final detailResult = jsonDecode(detailBody);
      DetailProductModel listDetail = DetailProductModel.fromJson(detailResult);
      emit(DetailLoaded(detailProductList: listDetail));
    } catch (error) {
      emit(DetailError());
    }
  }
}
