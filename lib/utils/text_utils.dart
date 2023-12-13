part of 'utils.dart';

extension StringCasingExtension on String {
  String toCapitalize() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalize())
      .join(' ');
  String convertSnakeCaseToNormal() {
    List<String> parts = this.split('_');
    String result = parts[0];

    for (int i = 1; i < parts.length; i++) {
      result += parts[i][0].toUpperCase() + parts[i].substring(1);
    }

    return result;
  }
}

String removeAllHtmlTags(String htmlText) {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  return htmlText.replaceAll(exp, '');
}
