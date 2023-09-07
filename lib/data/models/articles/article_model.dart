class ArticleModel {
  final int artId;
  final String image;
  final String title;
  final String description;
  final String likes;
  final String views;
  final String addDate;
  final String username;
  final String avatar;
  final String profession;
  final int userId;

  ArticleModel({
    required this.artId,
    required this.image,
    required this.title,
    required this.description,
    required this.likes,
    required this.views,
    required this.addDate,
    required this.username,
    required this.avatar,
    required this.profession,
    required this.userId,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      artId: json["art_id"] as int? ?? 0,
      image: json["image"] as String? ?? "",
      title: json["title"] as String? ?? "",
      description: json["description"] as String? ?? "",
      likes: json["likes"] as String? ?? '',
      views: json["views"] as String? ?? '',
      addDate: json["add_date"] as String? ?? "",
      username: json["username"] as String? ?? "",
      avatar: json["avatar"] as String? ?? "",
      profession: json["profession"] as String? ?? "",
      userId: json["user_id"] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "image": image,
      "title": title,
      "description": description,
      "hashtag":"#hashtag"
    };
  }

  @override
  String toString() {
    return '''
      title: $title,
      description: $description,
      image: $image,
    ''';
  }

  ArticleModel copyWith({
    int? artId,
    String? image,
    String? title,
    String? description,
    String? likes,
    String? views,
    String? addDate,
    String? username,
    String? avatar,
    String? profession,
    int? userId,
  }) =>
      ArticleModel(
        artId: artId ?? this.artId,
        image: image ?? this.image,
        title: title ?? this.title,
        description: description ?? this.description,
        likes: likes ?? this.likes,
        views: views ?? this.views,
        addDate: addDate ?? this.addDate,
        username: username ?? this.username,
        avatar: avatar ?? this.avatar,
        profession: profession ?? this.profession,
        userId: userId ?? this.userId,
      );
}
