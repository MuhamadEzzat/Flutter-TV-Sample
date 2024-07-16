class NumbersUtil {
  static String parseToEnglishNumbers(String numbers) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const arabic = ['٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩'];

    for (int i = 0; i < english.length; i++) {
      numbers = numbers.replaceAll(arabic[i], english[i]);
    }

    return numbers;
  }
}
