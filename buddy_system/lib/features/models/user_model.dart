class UserModel {
  final String uuid;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String createdDate;
  final String bio;
  final String profilePicUrl;

  const UserModel({
    required this.uuid,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.createdDate,
    this.bio = '',
    this.profilePicUrl = '',
  });

  String get fullName => '$firstName $lastName'.trim();

  String get initials {
    final f = firstName.isNotEmpty ? firstName[0] : '';
    final l = lastName.isNotEmpty ? lastName[0] : '';
    final combined = '$f$l'.toUpperCase();
    return combined.isNotEmpty
        ? combined
        : (username.isNotEmpty ? username[0].toUpperCase() : 'B');
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uuid: json['uuid']?.toString() ?? '',
      username: json['username']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
      createdDate: json['createdDate']?.toString() ?? '',
      bio: json['bio']?.toString() ?? '',
      profilePicUrl: json['profilePicUrl']?.toString() ?? '',
    );
  }
}
