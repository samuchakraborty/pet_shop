
class AllProductHome {
  AllProductHome({
    this.id,
    this.name,
    this.image,
    this.type,
    this.description,
    this.price,
    this.offerPrice,
    this.userId,
    this.status,
    this.qty =1
    // this.createdAt,
    // this.updatedAt,
  });

  final int? id;
  final String? name;
  final String? image;
  final String? type;
  final String? description;
  final double? price;
  final double? offerPrice;
  final int? userId;
  final int? status;
   int qty;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  factory AllProductHome.fromJson(Map<String, dynamic> json) => AllProductHome(
    id: json["id"],
    name: json["name"],
    image: json["image"] == null ? null : json["image"],
    type: json["type"],
    description: json["description"],
    price: json["price"].toDouble(),
    offerPrice: json["offer_price"] == null ? null : json["offer_price"].toDouble(),
    userId: json["user_id"],
    status: json["status"],

    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "type": type,
    "description": description,
    "price": price,
    "offer_price": offerPrice,
    "user_id": userId,
    "status": status,

    // "created_at": createdAt.toIso8601String(),
    // "updated_at": updatedAt.toIso8601String(),
  };
}
