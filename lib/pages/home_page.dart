import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter_widget/pages/error/not_found_page.dart';
import 'package:learn_flutter_widget/view_models/bloc/product_cubit/product_cubit.dart';
import 'package:learn_flutter_widget/view_models/bloc/theme_cubit/theme_cubit.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = false;
    ProductCubit myProductCubit = BlocProvider.of<ProductCubit>(context);
    ThemeCubit myThemeCubit = context.read<ThemeCubit>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        centerTitle: true,
        title: Text(
          'E-Commerce App',
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Theme.of(context).colorScheme.onPrimary),
        ),
        leading: const Icon(null),
        actions: [
          // IconButton(
          //   onPressed: () {
          //     myThemeCubit.changeTheme();
          //   },
          //   icon: Icon(
          //     Icons.change_circle,
          //     color: Theme.of(context).colorScheme.onPrimary,
          //   ),
          // ),
          Switch(
            value: isDarkMode,
            onChanged: (value) => myThemeCubit.changeTheme(),
            activeTrackColor: Colors.green,
          )
        ],
      ),
      body: BlocBuilder<ProductCubit, ProductState>(
        bloc: myProductCubit,
        builder: (context, state) {
          if (state is ProductLoading) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  ),
                  GradientText(
                    'Load data...',
                    colors: const <Color>[Colors.purple, Colors.lightBlue],
                    style: const TextStyle(fontSize: 24),
                  )
                ],
              ),
            );
          } else if (state is ProductLoaded) {
            final productData = state.productResult;
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1 / 1.3),
              itemBuilder: (context, index) {
                final productResult = productData[index];
                return InkWell(
                  borderRadius: BorderRadius.circular(15),
                  onTap: () {
                    Navigator.pushNamed(context, '/detailPage', arguments: {'id': productResult.id});
                  },
                  child: Card(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 130,
                          padding: const EdgeInsets.all(8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              productResult.thumbnail,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            productResult.title,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            'Category: ${productResult.category}.',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: Text(
                            productResult.description,
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondaryContainer,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: productData.length,
            );
          } else if (state is ProductError) {
            return Center(
                child: GradientText(
              'Error!',
              colors: const <Color>[Colors.purple, Colors.lightBlue],
              style: const TextStyle(fontSize: 24),
            ));
          } else {
            return const NotFoundPage();
          }
        },
      ),
    );
  }
}
