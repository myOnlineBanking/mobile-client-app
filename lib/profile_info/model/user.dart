class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final String address;
  final String phone;
  final String agencyName;
  final bool isDarkMode;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.isDarkMode,
    required this.address,
    required this.phone,
    required this.agencyName,
  });
}
