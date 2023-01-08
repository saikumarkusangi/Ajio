// To parse this JSON data, do
//
//     final productsModel = productsModelFromJson(jsonString);

import 'dart:convert';

ProductsModel? productsModelFromJson(String str) => ProductsModel.fromJson(json.decode(str));

String productsModelToJson(ProductsModel? data) => json.encode(data!.toJson());

class ProductsModel {
    ProductsModel({
        this.data,
        this.meta,
    });

    List<Product?>? data;
    Meta? meta;

    factory ProductsModel.fromJson(Map<String, dynamic> json) => ProductsModel(
        data: json["data"] == null ? [] : List<Product?>.from(json["data"]!.map((x) => Product.fromJson(x))),
        meta: Meta.fromJson(json["meta"]),
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x!.toJson())),
        "meta": meta!.toJson(),
    };
}

class Product {
    Product({
        this.id,
        this.attributes,
    });

    int? id;
    Attributes? attributes;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        attributes: Attributes.fromJson(json["attributes"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "attributes": attributes!.toJson(),
    };
}

class Attributes {
    Attributes({
        this.brand,
        this.description,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.publishedAt,
    });

    String? brand;
    String? description;
    int? price;
    DateTime? createdAt;
    DateTime? updatedAt;
    DateTime? publishedAt;

    factory Attributes.fromJson(Map<String, dynamic> json) => Attributes(
        brand: json["Brand"],
        description: json["Description"],
        price: json["Price"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        publishedAt: DateTime.parse(json["publishedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "Brand": brand,
        "Description": description,
        "Price": price,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
        "publishedAt": publishedAt?.toIso8601String(),
    };
}

class Meta {
    Meta({
        this.pagination,
    });

    Pagination? pagination;

    factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        pagination: Pagination.fromJson(json["pagination"]),
    );

    Map<String, dynamic> toJson() => {
        "pagination": pagination!.toJson(),
    };
}

class Pagination {
    Pagination({
        this.page,
        this.pageSize,
        this.pageCount,
        this.total,
    });

    int? page;
    int? pageSize;
    int? pageCount;
    int? total;

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"],
        pageSize: json["pageSize"],
        pageCount: json["pageCount"],
        total: json["total"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "pageSize": pageSize,
        "pageCount": pageCount,
        "total": total,
    };
}
