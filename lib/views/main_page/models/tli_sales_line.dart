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
  String itemDescription;
  String type;
  String no;
  num quantity;
  num unitPrice;
  String? comment;

  TliSalesLineElement(
      {required this.lineNo,
      required this.type,
      required this.no,
      required this.quantity,
      required this.unitPrice,
      required this.itemDescription,
      this.comment});

  factory TliSalesLineElement.fromJson(Map<String, dynamic> json) =>
      TliSalesLineElement(
        lineNo: json["lineNo"],
        type: 'Item',
        no: json["no"],
        quantity: json["quantity"],
        unitPrice: json["unitPrice"],
        itemDescription: json['itemDescription'],
        comment: json['comment'],
      );

  Map<String, dynamic> toJson() => {
        "lineNo": lineNo,
        "type": 'Item',
        "no": no,
        "quantity": quantity,
        "unitPrice": unitPrice,
        'itemDescription': itemDescription,
        'comment': comment
      };
}
