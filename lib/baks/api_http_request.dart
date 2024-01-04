import 'credit_cards.dart';
import 'package:http/http.dart' as http;

class ApiHttpRequest {
  Future<CreditCards?> get cards async {
    final http.Response response = await http
        .get(Uri.parse('https://fasoluciones.mx/ApiApp/CreditCards.php'));
    if (response.statusCode == 200) {
      print(response.body);
      return creditCardsFromJson(response.body);
    }
  }
}
