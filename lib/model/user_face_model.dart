class UserFaceModel {
  String faceImage;

  UserFaceModel({
    required this.faceImage,
  });

  // from map
  factory UserFaceModel.fromMap(Map<String, dynamic> map) {
    return UserFaceModel(
      faceImage: map['faceImage'] ?? '',
    );
  }

  // to map
  Map<String, dynamic> toMap() {
    return {
      "faceImage": faceImage,
    };
  }
}
