class Member {
  int? id;
  String name;
  String mobile;
  String email;
  String city;
  String gender;
  String membership;

  Member({
    this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.city,
    required this.gender,
    required this.membership,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'email': email,
      'city': city,
      'gender': gender,
      'membership': membership,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      id: map['id'],
      name: map['name'],
      mobile: map['mobile'],
      email: map['email'],
      city: map['city'],
      gender: map['gender'],
      membership: map['membership'],
    );
  }
}