class LaptopApiModel {
  LaptopApiModel({
    required this.id,
    this.images,
    this.description,
    this.mrp,
    this.noofratings,
    this.price,
    this.rating,
    this.more,
  });

  final String id;
  final List? images;
  final double? rating;
  final int? noofratings;
  final String? description;
  final double? mrp;
  final double? price;
  final String? more;

  factory LaptopApiModel.fromDocument(Map laptopApi) {
    return LaptopApiModel(
      description: laptopApi['description'],
      id: laptopApi['id'],
      mrp: laptopApi['mrp'],
      noofratings: laptopApi['noofratings'],
      price: laptopApi['price'],
      rating: laptopApi['rating'],
      images: laptopApi['images'],
      more: laptopApi['more'],
    );
  }
}
