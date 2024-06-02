import 'package:flutter_dotenv/flutter_dotenv.dart';

class Envionment {
  static initEnviornment() async {
    await dotenv.load(fileName: ".env");
  }

  static String apiUrl = dotenv.env['API_URL'] ?? 'No está configurado API_URL';
}
