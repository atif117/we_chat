class AppUser {
  String? id;
  String? name;
  String? about;
  bool? isOnline;
  String? profilePhoto;
  String? pushToken;
  String? lastSeen;
  String? createdAt;
  String? email;

  AppUser(
      {this.id,
      this.name,
      this.about,
      this.isOnline = false,
      this.profilePhoto,
      this.pushToken,
      this.lastSeen,
      this.createdAt,
      this.email});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = Map<String, dynamic>();

    data["id"] = id;
    data["name"] = name;
    data['about'] = about;
    data['email'] = email;
    data['isOnline'] = isOnline;
    data['profilePhoto'] = profilePhoto;
    data['pushToken'] = pushToken;
    data['lastSeen'] = lastSeen;
    data['createdAt'] = createdAt;

    return data;
  }

  AppUser.fromJson(json, id) {
    this.id = id;
    name = json['name'] ?? "";
    about = json['about'] ?? "";
    email = json['email'] ?? "";
    isOnline = json['isOnline'] ?? false;
    profilePhoto = json['profilePhoto'];
    pushToken = json['pushToken'] ?? "";
    lastSeen = json['lastSeen'] ?? "";
    createdAt = json['createdAt'] ?? "";
  }
}
