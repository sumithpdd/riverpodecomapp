import 'package:json_annotation/json_annotation.dart';

part 'products.g.dart';

@JsonSerializable()
class Products {
  int? id;
  String? title;
  String? description;
  String? category;
  num? price;
  num? discountPercentage;
  num? rating;
  int? stock;
  List? tags;
  String? brand;
  String? sku;
  num? weight;
  Map<String, dynamic>? dimensions;
  String? warrantyInformation;
  String? shippingInformation;
  String? availabilityStatus;
  List? reviews;
  String? returnPolicy;
  int? minimumOrderQuantity;
  List? images;
  String? thumbnail;

  String? createdAt;
  String? updatedAt;
  Products({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.discountPercentage,
    this.rating,
    this.stock,
    this.tags,
    this.brand,
    this.sku,
    this.weight,
    this.dimensions,
    this.warrantyInformation,
    this.shippingInformation,
    this.availabilityStatus,
    this.reviews,
    this.returnPolicy,
    this.minimumOrderQuantity,
    this.images,
    this.thumbnail,
    this.createdAt,
    this.updatedAt,
  }) : super();

  factory Products.fromJson(Map<String, dynamic> json) =>
      _$ProductsFromJson(json);

  Map<String, dynamic> toJson() => _$ProductsToJson(this);
}
