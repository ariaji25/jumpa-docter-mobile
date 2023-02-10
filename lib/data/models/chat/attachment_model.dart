class AttachmentModel {
  AttachmentModel({
    this.id,
    this.url,
    this.type,
  });

  String? id;
  String? url;
  String? type;

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      AttachmentModel(
        id: json["id"],
        url: json["url"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "type": type,
      };
}
