import 'dart:convert';

TliSalesLine tliSalesLineFromJson(String str) =>
    TliSalesLine.fromJson(json.decode(str));

String tliSalesLineToJson(TliSalesLine data) => json.encode(data.toJson());

class TliSalesLine {
  List<TliSalesLineElement> tliSalesLines;

  TliSalesLine({
    required this.tliSalesLines,
  });

  factory TliSalesLine.fromJson(Map<String, dynamic> json) => TliSalesLine(
        tliSalesLines: List<TliSalesLineElement>.from(
            json["tliSalesLines"].map((x) => TliSalesLineElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tliSalesLines":
            List<dynamic>.from(tliSalesLines.map((x) => x.toJson())),
      };
}

class TliSalesLineElement {
  int lineNo;
  String type;
  String no;
  num quantity;
  num unitPrice;

  TliSalesLineElement({
    required this.lineNo,
    required this.type,
    required this.no,
    required this.quantity,
    required this.unitPrice,
  });

  factory TliSalesLineElement.fromJson(Map<String, dynamic> json) =>
      TliSalesLineElement(
        lineNo: json["lineNo"],
        type: json["type"],
        no: json["no"],
        quantity: json["quantity"],
        unitPrice: json["unitPrice"],
      );

  Map<String, dynamic> toJson() => {
        "lineNo": lineNo,
        "type": type,
        "no": no,
        "quantity": quantity,
        "unitPrice": unitPrice,
      };
}



// class TliSalesLine {
//   String? lineNo;
//   String? type;
//   String? no;
//   num? quantity;
//   num? unitPrice;

//   TliSalesLine({
//     this.lineNo,
//     this.type,
//     this.no,
//     this.quantity,
//     this.unitPrice,
//   });

// // From JSON
//   factory TliSalesLine.fromJson(Map<String, dynamic> json) {
//     return TliSalesLine(
//       lineNo: json['lineNo'],
//       type: json['type'],
//       no: json['no'],
//       quantity: json['quantity'],
//       unitPrice: json['unitPrice'],
//     );
//   }

//   // To JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'lineNo': lineNo.toString(),
//       'type': type,
//       'no': no,
//       'quantity': quantity,
//       'unitPrice': unitPrice,
//     };
//   }
// }

// To parse this JSON data, do
//
//     final tliSalesLine = tliSalesLineFromJson(jsonString);

