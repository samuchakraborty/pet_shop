
class ShopWiseProductModel {
  ShopWiseProductModel({
    this.id,
    this.categoryId,
    this.subCategoryId,
    this.childCategoryId,
    this.unitId,
    this.brandId,
    this.warrentyId,
    this.deliveryPackageSizeId,
    this.sellerId,
    this.name,
    this.slug,
    this.shortDescription,
    this.description,
    this.image,
    this.thumb,
    this.status,
    this.downFor,
    this.downAt,

  });

  final int? id;
  final int? categoryId;
  final int? subCategoryId;
  final int? childCategoryId;
  final int? unitId;
  final int? brandId;
  final int? warrentyId;
  final int? deliveryPackageSizeId;
  final int? sellerId;
  final String? name;
  final String? slug;
  final String? shortDescription;
  final String? description;
  final String? image;
  final String? thumb;
  final String? status;
  final dynamic downFor;
  final dynamic downAt;


  factory ShopWiseProductModel.fromJson(Map<String, dynamic> json) => ShopWiseProductModel(
    id: json["id"],
    categoryId: json["category_id"],
    subCategoryId: json["sub_category_id"],
    childCategoryId: json["child_category_id"],
    unitId: json["unit_id"],
    brandId: json["brand_id"],
    warrentyId: json["warrenty_id"],
    deliveryPackageSizeId: json["delivery_package_size_id"],
    sellerId: json["seller_id"],
    name: json["name"],
    slug: json["slug"],
    shortDescription: json["short_description"],
    description: json["description"],
    image: json["image"],
    thumb: json["thumb"],
    status: json["status"],
    downFor: json["down_for"],
    downAt: json["down_at"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category_id": categoryId,
    "sub_category_id": subCategoryId,
    "child_category_id": childCategoryId,
    "unit_id": unitId,
    "brand_id": brandId,
    "warrenty_id": warrentyId,
    "delivery_package_size_id": deliveryPackageSizeId,
    "seller_id": sellerId,
    "name": name,
    "slug": slug,
    "short_description": shortDescription,
    "description": description,
    "image": image,
    "thumb": thumb,
    "status": status,
    "down_for": downFor,
    "down_at": downAt,

  };
}
