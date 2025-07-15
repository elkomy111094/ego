class UserProfileModel {
  UserProfileModel({
    required this.message,
    required this.status,
    required this.data,
  });
  late final String message;
  late final bool status;
  late final UserProfileData data;

  UserProfileModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = UserProfileData.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message;
    _data['status'] = status;
    _data['data'] = data.toJson();
    return _data;
  }
}

class UserProfileData {
  UserProfileData({
    required this.id,
    required this.firstName,
    required this.email,
    required this.nationalId,
    required this.gender,
    required this.genderName,
    required this.image,
  });
  late final int id;
  late final String firstName;
  late final String email;
  late final String nationalId;
  late final int gender;
  late final String genderName;
  late final String image;

  UserProfileData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['firstName'];
    email = json['email'];
    nationalId = json['nationalId'];
    gender = json['gender'];
    genderName = json['genderName'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['firstName'] = firstName;
    _data['email'] = email;
    _data['nationalId'] = nationalId;
    _data['gender'] = gender;
    _data['genderName'] = genderName;
    _data['image'] = image;
    return _data;
  }
}
