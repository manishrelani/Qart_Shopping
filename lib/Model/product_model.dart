import 'dart:convert';

class Product {
  String? season;
  String? brand;
  String? mood;
  String? gender;
  String? theme;
  String? category;
  String? name;
  String? option;
  String? color;
  String? subCategory;
  String? collection;
  String? fit;
  String? description;
  String? qrCode;
  String? looks;
  String? looksImageUrl;
  String? looksImage;
  String? fabric;
  String? finish;
  String? sizeWiseStock;
  String? defaultSize;
  String? material;
  String? quality;
  String? qrCode2;
  String? displayName;
  String? qpsCode;
  String? demandType;
  String? image;
  String? imageUrl;
  String? technology;
  String? technologyImage;
  String? technologyImageUrl;
  String? imageAlt;
  String? brandRank;
  int? displayOrder;
  int? minQuantity;
  int? maxQuantity;
  int? productClass;
  int? minimumArticleQuantity;
  double? likeablty;
  double? mrp;
  bool? promoted;
  bool? isCore;
  bool? adShoot;
  bool? secondary;
  bool? deactivated;
  List? availableSize;
  List? offerMonth;
  Map<String, dynamic>? ean;

  Product(
      {this.adShoot,
      this.availableSize,
      this.brand,
      this.brandRank,
      this.category,
      this.collection,
      this.color,
      this.deactivated,
      this.defaultSize,
      this.demandType,
      this.description,
      this.displayName,
      this.displayOrder,
      this.ean,
      this.fabric,
      this.finish,
      this.fit,
      this.gender,
      this.image,
      this.imageAlt,
      this.imageUrl,
      this.isCore,
      this.likeablty,
      this.looks,
      this.looksImage,
      this.looksImageUrl,
      this.material,
      this.maxQuantity,
      this.minQuantity,
      this.minimumArticleQuantity,
      this.mood,
      this.mrp,
      this.name,
      this.offerMonth,
      this.option,
      this.productClass,
      this.promoted,
      this.qpsCode,
      this.qrCode,
      this.qrCode2,
      this.quality,
      this.season,
      this.secondary,
      this.sizeWiseStock,
      this.subCategory,
      this.technologyImage,
      this.technologyImageUrl,
      this.theme,
      this.technology});

  factory Product.fromJson(var json) {
    return Product(
      adShoot: json["AdShoot"],
      availableSize: json["AvailableSizes"],
      brand: json["Brand"],
      brandRank: json["BrandRank"],
      category: json["Category"],
      imageAlt: json["ImageAlt"],
      collection: json["Collection"],
      color: json["Color"],
      deactivated: json["Deactivated"],
      defaultSize: json["DefaultSize"],
      demandType: json["DemandType"],
      description: json["Description"],
      displayName: json["DisplayName"],
      displayOrder: json["DisplayOrder"],
      ean: json["EAN"],
      fabric: json["Fabric"],
      finish: json["Finish"],
      fit: json["Fit"],
      gender: json["Gender"],
      image: json["Image"],
      imageUrl: json["ImageUrl"],
      isCore: json["IsCore"],
      likeablty: json["Likeabilty"],
      looks: json["Looks"],
      looksImage: json["LooksImage"],
      looksImageUrl: json["LooksImageUrl"],
      material: json["Material"],
      minQuantity: json["MinQuantity"],
      maxQuantity: json["MaxQuantity"],
      minimumArticleQuantity: json["MinimumArticleQuantity"],
      mood: json["Mood"],
      mrp: json["MRP"],
      name: json["Name"],
      offerMonth: json["OfferMonths"],
      option: json["Option"],
      productClass: json["ProductClass"],
      promoted: json["Promoted"],
      qpsCode: json["QPSCode"],
      qrCode2: json["QRCode2"],
      qrCode: json["QRCode"],
      quality: json["Quality"],
      season: json["Season"],
      secondary: json["Secondary"],
      sizeWiseStock: json["SizeWiseStock"],
      subCategory: json["SubCategory"],
      technology: json["Technology"],
      technologyImage: json["TechnologyImage"],
      technologyImageUrl: json["TechnologyImageUrl"],
      theme: json["Theme"],
    );
  }

  Map<String, dynamic> toMap() => {
        "AdShoot": this.adShoot,
        "AvailableSizes": this.availableSize,
        "Brand": this.brand,
        "BrandRank": this.brandRank,
        "Category": this.category,
        "Collection": this.collection,
        "Color": this.color,
        "Deactivated": this.deactivated,
        "DefaultSize": this.defaultSize,
        "DemandType": this.demandType,
        "Description": this.description,
        "DisplayName": this.displayName,
        "DisplayOrder": this.displayOrder,
        "EAN": this.ean,
        "Fabric": this.fabric,
        "Finish": this.finish,
        "Fit": this.fit,
        "Gender": this.gender,
        "Image": this.image,
        "ImageAlt": this.imageAlt,
        "ImageUrl": this.imageUrl,
        "IsCore": this.isCore,
        "Likeabilty": this.likeablty,
        "Looks": this.looks,
        "LooksImage": this.looksImage,
        "LooksImageUrl": this.looksImageUrl,
        "Material": this.material,
        "MinQuantity": this.minQuantity,
        "MaxQuantity": this.maxQuantity,
        "MinimumArticleQuantity": this.minimumArticleQuantity,
        "Mood": this.mood,
        "MRP": this.mrp,
        "Name": this.name,
        "OfferMonths": this.offerMonth,
        "Option": this.option,
        "ProductClass": this.productClass,
        "Promoted": this.promoted,
        "QPSCode": this.qpsCode,
        "QRCode2": this.qrCode2,
        "QRCode": this.qrCode,
        "Quality": this.quality,
        "Season": this.season,
        "Secondary": this.secondary,
        "SizeWiseStock": this.sizeWiseStock,
        "SubCategory": this.subCategory,
        "Technology": this.technology,
        "TechnologyImage": this.technologyImage,
        "TechnologyImageUrl": this.technologyImageUrl,
        "Theme": this.theme,
      };

  factory Product.fromString(String value) {
    return Product.fromJson(jsonDecode(value));
  }

  List<Product> fromList(List list) {
    List<Product> data = [];
    for (var i in list) {
      list.add(Product.fromJson(i));
    }
    return data;
  }
}
