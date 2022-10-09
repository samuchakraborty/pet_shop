

import 'all_product_model.dart';

class SellerProduct {
  SellerProduct({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  final int? currentPage;
  final List<AllProductHome>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  factory SellerProduct.fromJson(Map<String, dynamic> json) => SellerProduct(
    currentPage: json["current_page"],
    data: List<AllProductHome>.from(json["data"].map((x) => AllProductHome.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

// class Datum {
//   Datum({
//     this.id,
//     this.name,
//     this.image,
//     this.type,
//     this.description,
//     this.price,
//     this.offerPrice,
//     this.userId,
//     this.status,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   final int? id;
//   final String? name;
//   final String? image;
//   final String? type;
//   final String? description;
//   final int? price;
//   final int? offerPrice;
//   final int? userId;
//   final int? status;
//   final String? createdAt;
//   final String? updatedAt;
//
//   factory Datum.fromJson(Map<String, dynamic> json) => Datum(
//     id: json["id"],
//     name: json["name"],
//     image: json["image"],
//     type: json["type"],
//     description: json["description"],
//     price: json["price"],
//     offerPrice: json["offer_price"],
//     userId: json["user_id"],
//     status: json["status"],
//     createdAt:json["created_at"],
//     updatedAt: json["updated_at"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "image": image,
//     "type": type,
//     "description": description,
//     "price": price,
//     "offer_price": offerPrice,
//     "user_id": userId,
//     "status": status,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//   };
// }

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  final String? url;
  final String? label;
  final bool? active;

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url == null ? null : url,
    "label": label,
    "active": active,
  };
}
