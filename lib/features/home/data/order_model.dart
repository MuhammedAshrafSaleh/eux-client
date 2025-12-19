// lib/models/order_model.dart

class OrderModel {
  final String? orderCode;
  final String? receiver;
  final String? receiverPhoneNumber;
  final String? receiverPhoneNumber2;
  final String? arrivalGovernorate;
  final String? arrivalCity;
  final String? arrivalArea;
  final String? receiverStreet;
  final String? itemType;
  final String? itemName;
  final String? insuranceValue;
  final String? expressProduct;
  final String? exDrDescription;
  final String? codCurrency;
  final String? codAmount;
  final String? fodAmount;
  final String? goodsWeight;
  final String? customerPickupNumber;
  final String? customerPickupInformation;
  final String? remarks;
  final String? rc;

  OrderModel({
    this.orderCode,
    this.receiver,
    this.receiverPhoneNumber,
    this.receiverPhoneNumber2,
    this.arrivalGovernorate,
    this.arrivalCity,
    this.arrivalArea,
    this.receiverStreet,
    this.itemType,
    this.itemName,
    this.insuranceValue,
    this.expressProduct,
    this.exDrDescription,
    this.codCurrency,
    this.codAmount,
    this.fodAmount,
    this.goodsWeight,
    this.customerPickupNumber,
    this.customerPickupInformation,
    this.remarks,
    this.rc,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderCode: json['Order code']?.toString(),
      receiver: json['*Recevier']?.toString(),
      receiverPhoneNumber: json["*Recevier's phonenumber"]?.toString(),
      receiverPhoneNumber2: json["Recevier's phonenumber2"]?.toString(),
      arrivalGovernorate: json['*Arrival governorate']?.toString(),
      arrivalCity: json['*Arrival city']?.toString(),
      arrivalArea: json['*Arrival area']?.toString(),
      receiverStreet: json['*Receiver street']?.toString(),
      itemType: json['Item type']?.toString(),
      itemName: json['Item name']?.toString(),
      insuranceValue: json['Insurance Value']?.toString(),
      expressProduct: json['Express product']?.toString(),
      exDrDescription: json['EX/DR Description']?.toString(),
      codCurrency: json['COD currency']?.toString(),
      codAmount: json['COD amount']?.toString(),
      fodAmount: json['FOD  amount']?.toString(),
      goodsWeight: json['Goods weight']?.toString(),
      customerPickupNumber: json["Customer's pickup number"]?.toString(),
      customerPickupInformation: json["Customer's pickup information"]
          ?.toString(),
      remarks: json['Remarks']?.toString(),
      rc: json['RC']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Order code': orderCode,
      '*Recevier': receiver,
      "*Recevier's phonenumber": receiverPhoneNumber,
      "Recevier's phonenumber2": receiverPhoneNumber2,
      '*Arrival governorate': arrivalGovernorate,
      '*Arrival city': arrivalCity,
      '*Arrival area': arrivalArea,
      '*Receiver street': receiverStreet,
      'Item type': itemType,
      'Item name': itemName,
      'Insurance Value': insuranceValue,
      'Express product': expressProduct,
      'EX/DR Description': exDrDescription,
      'COD currency': codCurrency,
      'COD amount': codAmount,
      'FOD  amount': fodAmount,
      'Goods weight': goodsWeight,
      "Customer's pickup number": customerPickupNumber,
      "Customer's pickup information": customerPickupInformation,
      'Remarks': remarks,
      'RC': rc,
    };
  }
}
