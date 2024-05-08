class UserModel {
  final String name;
  final String email;
  final String uid;
  final String gender;
  final String photourl;
  UserModel({
    required this.name,
    required this.email,
    required this.uid,
    required this.gender,
    required this.photourl,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? uid,
    String? gender,
    String? photourl,
  }) {
    return UserModel(
      name: name ?? this.name,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      gender: gender ?? this.gender,
      photourl: photourl ?? this.photourl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'uid': uid,
      'gender': gender,
      'photourl': photourl,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
      gender: map['gender'] as String,
      photourl: map['photourl'] as String,
    );
  }
}
