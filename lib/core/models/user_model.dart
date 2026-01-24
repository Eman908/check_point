class UserModel {
  final String userName;
  final String userId;
  final String email;
  final String role;

  UserModel({
    required this.userName,
    required this.userId,
    required this.email,
    required this.role,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'],
      userId: json['userId'],
      email: json['email'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() => {
    'userName': userName,
    'userId': userId,
    'email': email,
    'role': role,
  };
}
