class UserModel {
  String firstname;
  String lastname;
  String email;
  String age;
  String adhaar;
  String pan;
  String address;
  String district;
  String city;
  String pin;
  String profilePic;
  String createdAt;
  String phoneNumber;
  String uid;
  String adhaarImage;
  String panImage;
  String unique;

  UserModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.age,
    required this.adhaar,
    required this.pan,
    required this.address,
    required this.district,
    required this.city,
    required this.pin,
    required this.profilePic,
    required this.createdAt,
    required this.phoneNumber,
    required this.uid,
    required this.adhaarImage,
    required this.panImage,
    required this.unique,
  });

  // from map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      firstname: map['firstname'] ?? '',
      lastname: map['lastname'] ?? '',
      email: map['email'] ?? '',
      age: map['age'] ?? '',
      adhaar: map['adhaar'] ?? '',
      pan: map['pan'] ?? '',
      address: map['address'] ?? '',
      district: map['district'] ?? '',
      city: map['city'] ?? '',
      pin: map['pin'] ?? '',
      uid: map['uid'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      createdAt: map['createdAt'] ?? '',
      profilePic: map['profilePic'] ?? '',
      adhaarImage: map['adhaarImage'] ?? '',
      panImage: map['panImage'] ?? '',
      unique: map['unique'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "age": age,
      "adhaar": adhaar,
      "pan": pan,
      "uid": uid,
      "address": address,
      "district": district,
      "city": city,
      "pin": pin,
      "profilePic": profilePic,
      "phoneNumber": phoneNumber,
      "createdAt": createdAt,
      "adhaarImage": adhaarImage,
      "panImage": panImage,
      "unique":unique,
    };
  }
}
