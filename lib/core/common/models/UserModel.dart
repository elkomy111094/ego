class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? profileImage;
  final String language;
  final bool isVerified;
  final String? token; // ← أضفنا التوكين هنا

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profileImage,
    this.language = 'en',
    this.isVerified = false,
    this.token,
  });

  // تحويل من JSON إلى UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'],
      profileImage: json['profileImage'],
      language: json['language'] ?? 'en',
      isVerified: json['isVerified'] ?? false,
      token: json['token'],
    );
  }

  // تحويل من UserModel إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profileImage': profileImage,
      'language': language,
      'isVerified': isVerified,
      'token': token,
    };
  }

  // تعديل نسخة من الكائن
  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profileImage,
    String? language,
    bool? isVerified,
    String? token,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profileImage: profileImage ?? this.profileImage,
      language: language ?? this.language,
      isVerified: isVerified ?? this.isVerified,
      token: token ?? this.token,
    );
  }
}
