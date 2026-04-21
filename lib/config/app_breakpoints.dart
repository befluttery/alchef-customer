class AppBreakpoints {
  AppBreakpoints._();

  // Width thresholds
  static const double mobileMax = 600;
  static const double tabletMax = 1200;
  // > 1024 is desktop

  static bool isMobile(double width) => width < mobileMax;
  static bool isTablet(double width) => width >= mobileMax && width < tabletMax;
  static bool isDesktop(double width) => width >= tabletMax;
}
