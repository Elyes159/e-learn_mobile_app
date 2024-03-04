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
  List<Courses> _coursess = [
    Courses(name: 'Anglais', code: 'en', imageUrl: 'assets/english_flag.png'),
    Courses(name: 'Français', code: 'fr', imageUrl: 'assets/french_flag.png'),
    Courses(name: 'Arabe', code: 'ar', imageUrl: 'assets/french_flag.png'),
  ];

  List<Courses> get coursess => _coursess;
}
