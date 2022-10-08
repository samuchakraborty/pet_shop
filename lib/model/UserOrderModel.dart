
class UserOrderModel {
    UserOrderModel({
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
    final List<Datum>? data;
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

    factory UserOrderModel.fromJson(Map<String, dynamic> json) => UserOrderModel(
        currentPage: json["current_page"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
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

class Datum {
    Datum({
        this.id,
        this.userId,
        this.orderNo,
        this.total,
        this.subtotal,
        this.adminCommission,
        this.deliveryCharge,
        this.vat,
        this.note,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.orderItem,
    });

    final int? id;
    final int? userId;
    final String? orderNo;
    final double? total;
    final int? subtotal;
    final double? adminCommission;
    final int? deliveryCharge;
    final double? vat;
    final String? note;
    final String? status;
    final String? createdAt;
    final String? updatedAt;
    final List<OrderItem>? orderItem;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        userId: json["user_id"],
        orderNo: json["order_no"],
        total: json["total"].toDouble(),
        subtotal: json["subtotal"],
        adminCommission: json["admin_commission"].toDouble(),
        deliveryCharge: json["delivery_charge"],
        vat: json["vat"].toDouble(),
        note: json["note"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        orderItem: List<OrderItem>.from(json["order_item"].map((x) => OrderItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "order_no": orderNo,
        "total": total,
        "subtotal": subtotal,
        "admin_commission": adminCommission,
        "delivery_charge": deliveryCharge,
        "vat": vat,
        "note": note,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "order_item": List<dynamic>.from(orderItem!.map((x) => x.toJson())),
    };
}

class OrderItem {
    OrderItem({
        this.id,
        this.petOrderId,
        this.petProductId,
        this.quantity,
        this.total,
        this.createdAt,
        this.updatedAt,
    });

    final int? id;
    final int? petOrderId;
    final int? petProductId;
    final int? quantity;
    final int? total;
    final String? createdAt;
    final String? updatedAt;

    factory OrderItem.fromJson(Map<String, dynamic> json) => OrderItem(
        id: json["id"],
        petOrderId: json["pet_order_id"],
        petProductId: json["pet_product_id"],
        quantity: json["quantity"],
        total: json["total"],
        createdAt:json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "pet_order_id": petOrderId,
        "pet_product_id": petProductId,
        "quantity": quantity,
        "total": total,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}

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
