part of 'utils.dart';

extension StringCasingExtension on String {
  String toCapitalize() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalize())
      .join(' ');
  String snakeCaseToWords() {
    List<String> parts = split('_');
    List<String> words = [];

    for (String part in parts) {
      words.add(part);
    }

    return words.join(' ');
  }

  String removeDiacriticsFromString() => removeDiacritics(this);
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}

String replaceMiddleWithUnderscores(String word) {
  if (word.length <= 2) {
    // No intermediate characters to replace
    return word;
  }

  // Get the characters at the beginning and end of the word
  String start = word.substring(0, 1);
  String end = word.substring(word.length - 1);

  // Create a string of underscores with the length of intermediate characters
  String middleUnderscores = '_' * (word.length - 2);

  // Concatenate the start, middle, and end characters with underscores
  return start + middleUnderscores + end;
}
