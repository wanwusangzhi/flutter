class UserInfo extends Object {
  String id;
  String name;

  UserInfo({
    this.id,
    this.name,
  });

  UserInfo.fromJson(json) {
    name = json['name'];
  }
}
