
class AllProductHome {
  AllProductHome({
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
    // this.downFor,
    // this.downAt,
    // this.deletedAt,
    // this.createdAt,
    // this.updatedAt,
    this.variants,
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
  // final dynamic downFor;
  // final dynamic downAt;
  // final dynamic deletedAt;
  // final DateTime createdAt;
  // final DateTime updatedAt;
  final List<Variant>? variants;

  factory AllProductHome.fromJson(Map<String, dynamic> json) => AllProductHome(
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
    // downFor: json["down_for"],
    // downAt: json["down_at"],
    // deletedAt: json["deleted_at"],
    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
    variants: List<Variant>.from(json["variants"].map((x) => Variant.fromJson(x))),
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
    // "down_for": downFor,
    // "down_at": downAt,
    // "deleted_at": deletedAt,
    // "created_at": createdAt.toIso8601String(),
    // "updated_at": updatedAt.toIso8601String(),
    "variants": List<dynamic>.from(variants!.map((x) => x.toJson())),
  };
}

class Variant {
  Variant({
    this.id,
    this.colorId,
    this.sizeId,
    this.productId,
    this.sku,
    this.price,
    this.salePrice,
    this.image,
    this.thumb,
    this.saleStartsAt,
    this.saleEndsAt,

  });

  final int? id;
  final int? colorId;
  final int? sizeId;
  final int? productId;
  final String? sku;
  final String? price;
  final dynamic salePrice;
  final String? image;
  final String? thumb;
  final dynamic saleStartsAt;
  final dynamic saleEndsAt;


  factory Variant.fromJson(Map<String, dynamic> json) => Variant(
    id: json["id"],
    colorId: json["color_id"],
    sizeId: json["size_id"],
    productId: json["product_id"],
    sku: json["sku"],
    price: json["price"],
    salePrice: json["sale_price"],
    image: json["image"],
    thumb: json["thumb"],
    saleStartsAt: json["sale_starts_at"],
    saleEndsAt: json["sale_ends_at"],

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "color_id": colorId,
    "size_id": sizeId,
    "product_id": productId,
    "sku": sku,
    "price": price,
    "sale_price": salePrice,
    "image": image,
    "thumb": thumb,
    "sale_starts_at": saleStartsAt,
    "sale_ends_at": saleEndsAt,

  };
}
