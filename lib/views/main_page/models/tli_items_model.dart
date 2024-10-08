import 'package:flutter/material.dart';

class TliItems {
  String? message;
  int? status;
  bool? success;
  List<ItemValue> value;

  TliItems({
    this.message,
    this.status,
    this.success,
    required this.value,
  });

  // fromJson method
  factory TliItems.fromJson(Map<String, dynamic> json) {
    return TliItems(
      message: json['message'] as String?,
      status: json['status'] as int?,
      success: json['success'] as bool?,
      value: (json['value'] as List<dynamic>)
          .map((item) => ItemValue.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'status': status,
      'success': success,
      'value': value.map((item) => item.toJson()).toList(),
    };
  }
}

class ItemValue {
  String? systemId;
  String? description;
  int? unitPrice;
  String? no;
  TextEditingController? qntyController;
  TextEditingController? notesController;

  ItemValue(
      {this.systemId,
      this.description,
      this.unitPrice,
      this.no,
      this.qntyController,
      this.notesController});

  // fromJson method
  factory ItemValue.fromJson(Map<String, dynamic> json) {
    return ItemValue(
      systemId: json['systemId'] as String?,
      description: json['description'] as String?,
      unitPrice: json['unitPrice'] as int?,
      no: json['no'] as String?,
      qntyController: TextEditingController(text: '1'),
      notesController: TextEditingController(text: ''),
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'systemId': systemId,
      'description': description,
      'unitPrice': unitPrice,
      'no': no,
    };
  }
}
