class Utils {
  static void getLogging({required bool isLog, required String message}) {
    if (isLog) print("LOGGING: $message");
  }
}