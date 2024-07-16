import 'package:flutter/material.dart';

class PaymentMethod {
  String? country;
  String? description;
  int? discountPercentage = 0;
  double? monthOriginalPrice;
  double? monthDiscountPrice;
  double? weekOriginalPrice;
  double? weekDiscountPrice;
  double? yearOriginalPrice;
  double? yearDiscountPrice;
  int? id;
  String? error;
  PriceConverted? monthDiscountPriceConverted;
  PriceConverted? monthOriginalPriceConverted;
  PriceConverted? weekDiscountPriceConverted;
  PriceConverted? weekOriginalPriceConverted;
  PaymentPayingMethodsId? paymentPayingMethodsId;
  PriceConverted? yearDiscountPriceConverted;
  PriceConverted? yearOriginalPriceConverted;

  PaymentMethod(
      {this.country,
      this.description,
      this.monthOriginalPrice,
      this.monthDiscountPrice,
      this.yearOriginalPrice,
      this.yearDiscountPrice,
      this.id,
      this.monthDiscountPriceConverted,
      this.monthOriginalPriceConverted,
      this.paymentPayingMethodsId,
      this.yearDiscountPriceConverted,
      this.yearOriginalPriceConverted,
      this.weekDiscountPrice,
      this.weekOriginalPrice,
      this.weekDiscountPriceConverted,
      this.weekOriginalPriceConverted});

  PaymentMethod.withError(this.error);

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    country = json['country'];
    description = json['description'];
    monthOriginalPrice = json['monthOriginalPrice'];
    monthDiscountPrice = json['monthDiscountPrice'];

    /// week
    weekOriginalPrice = json['weekOriginalPrice'];
    weekDiscountPrice = json['weekDiscountPrice'];

    yearOriginalPrice = json['yearOriginalPrice'];
    yearDiscountPrice = json['yearDiscountPrice'];
    id = json['id'];
    monthDiscountPriceConverted = json['monthDiscountPriceConverted'] != null
        ? PriceConverted.fromJson(json['monthDiscountPriceConverted'])
        : null;
    monthOriginalPriceConverted = json['monthOriginalPriceConverted'] != null
        ? PriceConverted.fromJson(json['monthOriginalPriceConverted'])
        : null;

    /// week
    weekDiscountPriceConverted = json['weekDiscountPriceConverted'] != null
        ? PriceConverted.fromJson(json['weekDiscountPriceConverted'])
        : null;
    weekOriginalPriceConverted = json['weekOriginalPriceConverted'] != null
        ? PriceConverted.fromJson(json['weekOriginalPriceConverted'])
        : null;
    paymentPayingMethodsId = json['paymentPayingMethodsId'] != null
        ? PaymentPayingMethodsId.fromJson(json['paymentPayingMethodsId'])
        : null;
    yearDiscountPriceConverted = json['yearDiscountPriceConverted'] != null
        ? PriceConverted.fromJson(json['yearDiscountPriceConverted'])
        : null;
    yearOriginalPriceConverted = json['yearOriginalPriceConverted'] != null
        ? PriceConverted.fromJson(json['yearOriginalPriceConverted'])
        : null;
    discountPercentage = yearOriginalPrice != null && yearDiscountPrice != null
        ? ((yearOriginalPrice! - yearDiscountPrice!) / yearOriginalPrice! * 100)
            .toInt()
        : 0;
  }

  PaymentMethod.fromFawryJson(Map<String, dynamic> json) {
    country = json['country'];
    description = json['description'];
    monthOriginalPrice = json['monthOriginalPrice'];
    monthDiscountPrice = json['monthDiscountPrice'];

    /// week
    weekOriginalPrice = json['weekOriginalPrice'];
    weekDiscountPrice = json['weekDiscountPrice'];

    yearOriginalPrice = json['yearOriginalPrice'];
    yearDiscountPrice = json['yearDiscountPrice'];
    id = json['id'];
    paymentPayingMethodsId = json['paymentPayingMethodsId'] != null
        ? PaymentPayingMethodsId.fromJson(json['paymentPayingMethodsId'])
        : null;

    /// week
    weekOriginalPriceConverted = PriceConverted(
        currencyName: paymentPayingMethodsId?.currency,
        currency: paymentPayingMethodsId?.currency,
        convertedPrice: weekOriginalPrice);
    weekDiscountPriceConverted = PriceConverted(
        currencyName: paymentPayingMethodsId?.currency,
        currency: paymentPayingMethodsId?.currency,
        convertedPrice: weekDiscountPrice);

    monthOriginalPriceConverted = PriceConverted(
        currencyName: paymentPayingMethodsId?.currency,
        currency: paymentPayingMethodsId?.currency,
        convertedPrice: monthOriginalPrice);

    yearOriginalPriceConverted = PriceConverted(
        currencyName: paymentPayingMethodsId?.currency,
        currency: paymentPayingMethodsId?.currency,
        convertedPrice: yearOriginalPrice);
    monthDiscountPriceConverted = PriceConverted(
        currencyName: paymentPayingMethodsId?.currency,
        currency: paymentPayingMethodsId?.currency,
        convertedPrice: monthDiscountPrice);
    yearDiscountPriceConverted = PriceConverted(
        currencyName: paymentPayingMethodsId?.currency,
        currency: paymentPayingMethodsId?.currency,
        convertedPrice: yearDiscountPrice);
    discountPercentage = yearOriginalPrice != null && yearDiscountPrice != null
        ? ((yearOriginalPrice! - yearDiscountPrice!) / yearOriginalPrice! * 100)
            .toInt()
        : 0;
    debugPrint(discountPercentage.toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['country'] = country;
    data['description'] = description;
    data['monthOriginalPrice'] = monthOriginalPrice;
    data['monthDiscountPrice'] = monthDiscountPrice;
    data['yearOriginalPrice'] = yearOriginalPrice;
    data['yearDiscountPrice'] = yearDiscountPrice;
    data['id'] = id;
    if (monthDiscountPriceConverted != null) {
      data['monthDiscountPriceConverted'] =
          monthDiscountPriceConverted!.toJson();
    }
    if (monthOriginalPriceConverted != null) {
      data['monthOriginalPriceConverted'] =
          monthOriginalPriceConverted!.toJson();
    }
    if (paymentPayingMethodsId != null) {
      data['paymentPayingMethodsId'] = paymentPayingMethodsId!.toJson();
    }
    if (yearDiscountPriceConverted != null) {
      data['yearDiscountPriceConverted'] = yearDiscountPriceConverted!.toJson();
    }
    if (yearOriginalPriceConverted != null) {
      data['yearOriginalPriceConverted'] = yearOriginalPriceConverted!.toJson();
    }
    return data;
  }
}

class PriceConverted {
  String? currency;
  String? currencyName;
  double? convertedPrice;

  PriceConverted({
    this.currency,
    this.currencyName,
    this.convertedPrice,
  });

  PriceConverted.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    currencyName = json['currencyName'];
    convertedPrice = json['convertedPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['currency'] = currency;
    data['currencyName'] = currencyName;
    data['convertedPrice'] = convertedPrice;
    return data;
  }
}

class PaymentPayingMethodsId {
  String? name;
  String? currency;
  int? id;

  PaymentPayingMethodsId({
    this.name,
    this.currency,
    this.id,
  });

  PaymentPayingMethodsId.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    currency = json['currency'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['currency'] = currency;
    data['id'] = id;
    return data;
  }
}
