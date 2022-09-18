import 'dart:convert';
import 'package:http/http.dart' as http;

class EmailApi {
  sendBillViaEmail({
    required toId,
    required subject,
    required toName,
    required productId,
    required productDetails,
    required productMoreDetails,
    required paymentMode,
    required mrp,
    required moneyPaid,
  }) async {
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    await http.post(
      url,
      headers: {
        'origin': 'https://localhost',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'service_id': 'service_2hn2s2k',
        'template_id': 'template_bcedwaj',
        'user_id': 'kwMuZzX8PZvXOJYDm',
        'template_params': {
          'to_email': toId,
          'subject': subject,
          'to_name': toName,
          'product_id': productId,
          'product_details': productDetails,
          'product_more_details': productMoreDetails,
          'payment_mode': paymentMode,
          'mrp': mrp,
          'money_paid': moneyPaid,
        }
      }),
    );
  }
}
