class Courses {
  final String name;
  final String code;
  final String imageUrl;

  Courses({
    required this.name,
    required this.code,
    required this.imageUrl,
  });
}

class CoursesManager {
  final List<Courses> _coursess = [
    Courses(name: 'Anglais', code: 'en', imageUrl: 'assets/english_flag.png'),
    Courses(name: 'Français', code: 'fr', imageUrl: 'assets/french_flag.png'),
    Courses(name: 'Arabe', code: 'ar', imageUrl: 'assets/arabic_flag.png'),
    Courses(name: 'espagnole', code: 'es', imageUrl: 'assets/esp_flag.png'),
    Courses(name: 'indian', code: 'hi', imageUrl: 'assets/ind_flag.png'),
  ];

  List<Courses> get coursess => _coursess;
}
