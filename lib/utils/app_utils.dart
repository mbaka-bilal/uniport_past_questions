const String basePath = 'assets/images';

extension Images on String {
  String get jpg => '$basePath/$this.jpg';
  String get webp => '$basePath/$this.webp';
}

class AppImages {
  static String onBoardingImageA = 'student_reading'.jpg;
  static String onBoardingImageB = 'celebrating_passing_exams'.jpg;
  static String dashboardImage = 'brain'.webp;
}