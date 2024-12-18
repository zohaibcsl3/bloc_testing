class CommentsModel {
  int? postId;
  int? id;
  String? name;
  String? email;
  String? body;

  CommentsModel({
    this.postId,
    this.id,
    this.name,
    this.email,
    this.body,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        postId: json["postId"] ?? 0,
        id: json["id"] ?? 0,
        name: json["name"] ?? "",
        email: json["email"] ?? "",
        body: json["body"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "postId": postId ?? 0,
        "id": id ?? 0,
        "name": name ?? "",
        "email": email ?? "",
        "body": body ?? "",
      };
}
