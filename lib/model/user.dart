class AppUser {
  String firstName;
  String lastName;
  String email;
  String? password;
  String contactNumber;
  String nationality;
  String city;
  String address;
  String pin;

  AppUser({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.password,
    required this.contactNumber,
    required this.nationality,
    required this.city,
    required this.address,
    required this.pin,
  });

  static AppUser fromJson(json) {
    return AppUser(
      firstName: json['first name'],
      lastName: json['last name'],
      email: json['email'],
      contactNumber: json['contact number'],
      nationality: json['nationality'],
      city: json['city'],
      address: json['address'],
      pin: json['pin'],
      
    );
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first name'] = this.firstName;
    data['last name'] = this.lastName;
    data['email'] = this.email;
    data['contact number'] = this.contactNumber;
    data['nationality'] = this.nationality;
    data['city'] = this.city;
    data['address'] = this.address;
    data['pin'] = this.pin;
    return data;
  }
}
