import 'package:translator/translator.dart';

Future<String> translate(String text, String targetLanguage) async {
  final translator = GoogleTranslator();

  Translation translation =
      await translator.translate(text, to: targetLanguage);
  return translation.text ?? text;
}
