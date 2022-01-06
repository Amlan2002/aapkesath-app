class AppUser {
  String firstName;
  String lastName;
  String gender;
  DateTime dob;
  String nationality;
  String city;
  String address;
  String pin;

  AppUser({
    required this.firstName,
    required this.lastName,
    required this.dob,
    required this.gender,
    required this.nationality,
    required this.city,
    required this.address,
    required this.pin,
  });

  static AppUser fromJson(json) {
    return AppUser(
        firstName: json['first name'],
        lastName: json['last name'],
        nationality: json['nationality'],
        city: json['city'],
        address: json['address'],
        pin: json['pin'],
        dob: json['date of birth'].toDate(),
        gender: json['gender']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first name'] = this.firstName;
    data['last name'] = this.lastName;
    data['nationality'] = this.nationality;
    data['city'] = this.city;
    data['address'] = this.address;
    data['date of birth'] = this.dob;
    data['gender'] = this.gender;
    data['pin'] = this.pin;
    return data;
  }
}
