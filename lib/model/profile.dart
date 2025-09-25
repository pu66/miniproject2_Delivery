// profile_model.dart
enum UserType { user, rider }

class Profile {
  String uid;
  String email;
  String password;
  String? name;
  UserType userType;

  Profile({
    this.uid = '',
    required this.email,
    required this.password,
    this.name,
    required this.userType,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'userType': userType.toString().split('.').last,
    };
  }

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      password: '',
      name: map['name'],
      userType: map['userType'] == 'rider' ? UserType.rider : UserType.user,
    );
  }
}
