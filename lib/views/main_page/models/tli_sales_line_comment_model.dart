import 'dart:convert';

TliSalesComment tliSalesCommentFromJson(String str) =>
    TliSalesComment.fromJson(json.decode(str));

String tliSalesCommentToJson(TliSalesComment data) =>
    json.encode(data.toJson());

class TliSalesComment {
  List<TliSalesCommentElement> tliSalesComments;

  TliSalesComment({
    required this.tliSalesComments,
  });

  factory TliSalesComment.fromJson(Map<String, dynamic> json) =>
      TliSalesComment(
        tliSalesComments: List<TliSalesCommentElement>.from(
            json["tliSalesComments"]
                .map((x) => TliSalesCommentElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tliSalesComments":
            List<dynamic>.from(tliSalesComments.map((x) => x.toJson())),
      };
}

class TliSalesCommentElement {
  String no;
  int documentLineNo;
  int lineNo;
  DateTime date;
  String comment;

  TliSalesCommentElement({
    required this.no,
    required this.documentLineNo,
    required this.lineNo,
    required this.date,
    required this.comment,
  });

  factory TliSalesCommentElement.fromJson(Map<String, dynamic> json) =>
      TliSalesCommentElement(
        no: json["no"],
        documentLineNo: json["documentLineNo"],
        lineNo: json["lineNo"],
        date: DateTime.parse(json["date"]),
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "no": no,
        "documentLineNo": documentLineNo,
        "lineNo": lineNo,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "comment": comment,
      };
}
