class ProductModel {
  final int id;
  final String title;
  final String description;
  final int price;
  final num discount;
  final num rating;
  final int stock;
  final String brand;
  final String category;
  final String thumbnail;
  final List images;

  ProductModel(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.discount,
      required this.rating,
      required this.stock,
      required this.brand,
      required this.category,
      required this.thumbnail,
      required this.images});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        price: json['price'],
        discount: json['discountPercentage'],
        rating: json['rating'],
        stock: json['stock'],
        brand: json['brand'],
        category: json['category'],
        thumbnail: json['thumbnail'],
        images: json['images']);
  }
}
