
import 'dart:ffi';

class Doctors {
  String dImage;
  String dName;
  String dExperience;
  String dSpecialist;
  String dJob;
  String appointmentFeeText;
  Double appointmentFee;

  Doctors({
    required this.dImage,
    required this.dName,
    required this.dExperience,
    required this.dSpecialist,
    required this.dJob,
    required this.appointmentFeeText,
    required this.appointmentFee,
  });
}