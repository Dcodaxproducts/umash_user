class PolicyModel {
  Pages? returnPage;
  Pages? refundPage;
  Pages? cancellationPage;

  PolicyModel({
    this.returnPage,
    this.refundPage,
    this.cancellationPage,
  });

  factory PolicyModel.fromJson(Map<String, dynamic> json) => PolicyModel(
        returnPage: Pages.fromJson(json["return_page"]),
        refundPage: Pages.fromJson(json["refund_page"]),
        cancellationPage: Pages.fromJson(json["cancellation_page"]),
      );
}

class Pages {
  bool status;
  String content;

  Pages({
    required this.status,
    required this.content,
  });

  factory Pages.fromJson(Map<String, dynamic> json) => Pages(
        status: json["status"],
        content: json["content"],
      );
}
