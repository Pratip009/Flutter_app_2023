class UserModel {
  String name;
  String email;
  String age;
  String adhaar;
  String pan;
  String address;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String uid;
  String adhaarImage;
  String panImage;

  UserModel({
    required this.name,
    required this.email,
    required this.age,
    required this.adhaar,
    required this.pan,
    required this.address,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
    required this.adhaarImage,
    required this.panImage,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      age: map['age'] ?? '',
      adhaar: map['adhaar'] ?? '',
      pan: map['pan'] ?? '',
      address: map['address'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profilePic: map['profilePic'] ?? '',
      adhaarImage: map['adhaarImage'] ?? '',
      panImage: map['panImage'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "age": age,
      "adhaar": adhaar,
      "pan": pan,
      "uid": uid,
      "address": address,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "adhaarImage": adhaarImage,
      "panImage": panImage,
    };
  }
}
