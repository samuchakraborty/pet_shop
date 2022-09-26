
class SellerModel {
  SellerModel({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
   // this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  final int? currentPage;
  final List<Datum>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
//  final List<Link>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  factory SellerModel.fromJson(Map<String, dynamic> json) => SellerModel(
    currentPage: json["current_page"],
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
   // links: List<Link>.from(json["links"].map((x) => Link.fromJson(x))),
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
  //  "links": List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class Datum {
  Datum({
    this.id,
    this.userId,
    this.shopName,
    this.slug,
    this.logo,
    this.profilePicture,
    this.isSpecial,
    this.specialOrder,
    this.ownerName,
    this.registrationNo,
    this.corporateAddress,
    this.vatRegNo,
    this.nationalIdNo,
    this.tradingLicenseNo,
    this.productCategory,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  final int? id;
  final int? userId;
  final String? shopName;
  final String? slug;
  final String? logo;
  final String? profilePicture;
  final int? isSpecial;
  final String? specialOrder;
  final dynamic ownerName;
  final dynamic registrationNo;
  final dynamic corporateAddress;
  final dynamic vatRegNo;
  final dynamic nationalIdNo;
  final dynamic tradingLicenseNo;
  final dynamic productCategory;
  final String? status;
  final dynamic createdAt;
  final dynamic updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    shopName: json["shop_name"],
    slug: json["slug"],
    logo: json["logo"],
    profilePicture: json["profile_picture"],
    isSpecial: json["is_special"],
    specialOrder: json["special_order"],
    ownerName: json["owner_name"],
    registrationNo: json["registration_no"],
    corporateAddress: json["corporate_address"],
    vatRegNo: json["vat_reg_no"],
    nationalIdNo: json["national_id_no"],
    tradingLicenseNo: json["trading_license_no"],
    productCategory: json["product_category"],
    status: json["status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "shop_name": shopName,
    "slug": slug,
    "logo": logo,
    "profile_picture": profilePicture,
    "is_special": isSpecial,
    "special_order": specialOrder,
    "owner_name": ownerName,
    "registration_no": registrationNo,
    "corporate_address": corporateAddress,
    "vat_reg_no": vatRegNo,
    "national_id_no": nationalIdNo,
    "trading_license_no": tradingLicenseNo,
    "product_category": productCategory,
    "status": status,
    "created_at": createdAt,
    "updated_at": updatedAt,
  };
}

// class Link {
//   Link({
//     this.url,
//     this.label,
//     this.active,
//   });
//
//   final String url;
//   final String label;
//   final bool active;
//
//   factory Link.fromJson(Map<String, dynamic> json) => Link(
//     url: json["url"] == null ? null : json["url"],
//     label: json["label"],
//     active: json["active"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "url": url == null ? null : url,
//     "label": label,
//     "active": active,
//   };
// }
