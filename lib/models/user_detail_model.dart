class UserModel {
  final int id;
  final String name;
  final String phone;
  final String? accountType;
  final String? companyName;
  final String? companyAddress;
  final int? lawyerType;
  final String? profile_path;
  final String? lawyerExperience;
  final String? lawyerEducation;
  final String? lawyerAbout;
  final int? lawyerFees;
  final String email;
  final int? emailVerifiedAt;
  final String? profile;
  final String? company_profession;
  final int role;
  final int? otp;
  final String? otpExpireAt;
  final int isVerified;
  final String? createdAt;
  final String? updatedAt;
  final String? countryCode;

  UserModel({
    required this.id,
    required this.name,
    required this.phone,
    this.profile_path,
    this.company_profession,
    this.countryCode,
    this.accountType,
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
    this.otp,
    this.otpExpireAt,
    required this.isVerified,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      phone: json['phone'],
      accountType: json['account_type'],
      companyName: json['company_name'] ?? '',
      companyAddress: json['company_address'] ?? '',
      company_profession: json['company_profession'] ?? '',
      lawyerType: json['lawyer_type'] ?? 0,
      lawyerExperience: json['lawyer_experience'] ?? '',
      lawyerEducation: json['lawyer_education'] ?? '',
      lawyerAbout: json['lawyer_about'] ?? '',
      lawyerFees: json['lawyer_fees'] ?? 0,
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      profile: json['profile'],
      countryCode: json['country_code'] ?? '+1',
      profile_path: json['profile_path'] ??
          'https://huntfish-live.azsolutionspk.com/uploads/profiles/sample.png',
      role: json['role'],
      otp: json['otp'],
      otpExpireAt: json['otp_expire_at'],
      isVerified: json['is_verified'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
