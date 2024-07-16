class Child {
  final int id;
  final dynamic status;
  final String name;
  final String? password;
  final String dateOfBirth;
  final String? gender;
  final String? profilePicture;
  final String dailyUsage;
  String? lastUsageDate;
  final String? error;

  Child({
    this.id = -1,
    this.status = "",
    this.name = "",
    this.password = "",
    this.dateOfBirth = "",
    this.gender = "male",
    this.profilePicture = "",
    this.dailyUsage = "23:59",
    this.lastUsageDate = "",
    this.error,
  });
  Child.withError(String errorValue)
      : id = -1,
        status = "",
        name = "",
        password = "",
        dateOfBirth = "",
        gender = "male",
        profilePicture = "",
        dailyUsage = "23:59",
        lastUsageDate = "",
        error = errorValue;

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
        id: json['id'],
        status: json['status'],
        name: json['name'],
        password: json['password'],
        dateOfBirth: json['dateOfBirth'],
        gender: json['gender'],
        profilePicture: json['profilePicture'],
        lastUsageDate: json['lastUsageDate'],
        dailyUsage: json['dailyUsage']);
  }
}
