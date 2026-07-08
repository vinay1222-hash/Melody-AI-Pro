class Member {
  final String id;
  final String name;
  final String mobile;
  final String email;
  final String city;
  final String gender;
  final String membership;
  final String photo;

  Member({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.city,
    required this.gender,
    required this.membership,
    required this.photo,
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
      'photo': photo,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      mobile: map['mobile'] ?? '',
      email: map['email'] ?? '',
      city: map['city'] ?? '',
      gender: map['gender'] ?? '',
      membership: map['membership'] ?? '',
      photo: map['photo'] ?? '',
    );
  }
}