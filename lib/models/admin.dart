class Admin {
  String username;
  int password;
  Admin(this.username, this.password);
  factory Admin.fromJson(dynamic json) {
    return Admin(json['name'] as String, json['age'] as int);
  }
  @override
  String toString() {
    return '{ ${this.username}, ${this.password} }';
  }
}