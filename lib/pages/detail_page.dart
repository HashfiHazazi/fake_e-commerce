import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:learn_flutter_widget/pages/error/not_found_page.dart';
import 'package:learn_flutter_widget/view_models/bloc/detail_cubit/detail_cubit.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    DetailCubit myDetailCubit = DetailCubit()..fetchDetail(id);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(
          'Details Page',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: BlocBuilder<DetailCubit, DetailState>(
          bloc: myDetailCubit,
          builder: (context, state) {
            if (state is DetailLoading) {
              return const Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Loading...',
                        style: TextStyle(color: Colors.green, fontSize: 32),
                      ),
                    ]),
              );
            } else if (state is DetailLoaded) {
              final detailData = state.detailProductList;
              final detailResult = detailData;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      items: detailResult.images.map(
                        (imagesCarousel) {
                          return Container(
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 4,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    strokeAlign: BorderSide.strokeAlignInside),
                                borderRadius: BorderRadius.circular(16)),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            width: double.infinity,
                            height: 250,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                '$imagesCarousel',
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        enlargeCenterPage: true,
                        autoPlayInterval: Durations.extralong4,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      detailResult.title,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RatingBar.builder(
                          itemSize: 24.0,
                          initialRating: detailResult.rating.toDouble(),
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4),
                          itemBuilder: ((context, index) {
                            return const Icon(
                              Icons.star,
                              color: Colors.amber,
                            );
                          }),
                          onRatingUpdate: (rating) => print(rating),
                        ),
                        Text(
                          '(${detailResult.rating}) of 5.0',
                          style: const TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$ ${detailResult.price}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            '-${detailResult.discount}% off',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: Colors.red),
                          ),
                        ]),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Product stock: ',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '${detailResult.stock} Items',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Brand: ',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      detailResult.brand,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Ceategory: ',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      detailResult.category,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      'Product desc: ',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      detailResult.description,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ],
                ),
              );
            } else if (state is DetailError) {
              return const Center(
                  child: Text(
                'Error guys!',
                style: TextStyle(color: Colors.red, fontSize: 32),
              ));
            } else {
              return const NotFoundPage();
            }
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 16, left: 16, bottom: 32),
        child: SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
              onPressed: () {
                showToast();
                // ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(content: Text('Added to your cart!')));
              },
              child: const Text('Add to cart')),
        ),
      ),
    );
  }
}

void showToast() {
  Fluttertoast.showToast(
    msg: "THE toast message",
    gravity: ToastGravity.CENTER,
    toastLength: Toast.LENGTH_SHORT,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 16.0,
  );
}
