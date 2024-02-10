class UserModel {
  final int id;
  final String name;
  final String phone;
  final String accountType;
  final String? companyName;
  final String? companyAddress;
  final int? lawyerType;
  final String? lawyerExperience;
  final String? lawyerEducation;
  final String? lawyerAbout;
  final String? lawyerFees;
  final String email;
  final int? emailVerifiedAt;
  final String? profile;
  final int role;
  final int otp;
  final String otpExpireAt;
  final int isVerified;
  final String createdAt;
  final String updatedAt;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.accountType,
    this.companyName,
    this.companyAddress,
    this.lawyerType,
    this.lawyerExperience,
    this.lawyerEducation,
    this.lawyerAbout,
    this.lawyerFees,
    required this.email,
    this.emailVerifiedAt,
    this.profile,
    required this.role,
    required this.otp,
    required this.otpExpireAt,
    required this.isVerified,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      accountType: json['account_type'],
      companyName: json['company_name'],
      companyAddress: json['company_address'],
      lawyerType: json['lawyer_type'],
      lawyerExperience: json['lawyer_experience'],
      lawyerEducation: json['lawyer_education'],
      lawyerAbout: json['lawyer_about'],
      lawyerFees: json['lawyer_fees'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      profile: json['profile'],
      role: json['role'],
      otp: json['otp'],
      otpExpireAt: json['otp_expire_at'],
      isVerified: json['is_verified'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
