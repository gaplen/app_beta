import 'dart:convert';

import 'package:app_beta/src/api/environment.dart';
import 'package:app_beta/src/models/mercado_pago_document_type.dart';
import 'package:app_beta/src/models/mercado_pago_payment_method_installments.dart';
import 'package:app_beta/src/models/order.dart';
import 'package:app_beta/src/models/user.dart';
import 'package:app_beta/src/utils/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class MercadoPagoProvider {

  String _urlMercadoPago = 'api.mercadopago.com';
  String _url = Environment.API_APP;
  final _mercadoPagoCredentials = Environment.mercadoPagoCredentials;

  BuildContext context;
  User user;

  Future init (BuildContext context, User user) {
    this.context = context;
    this.user = user;
  }

  Future<List<MercadoPagoDocumentType>> getIdentificationTypes() async {

    try {
      final url = Uri.https(_urlMercadoPago, '/v1/identification_types', {
        'access_token': _mercadoPagoCredentials.accessToken
      });

      final res = await http.get(url);
      final data = json.decode(res.body);
      final result = new MercadoPagoDocumentType.fromJsonList(data);

      return result.documentTypeList;
    } catch(e) {
      print('Error: $e');
      return null;
    }

  }

  Future<Response> createPayment({
    @required String cardId,
    @required double transactionAmount,
    @required int installments,
    @required String paymentMethodId,
    @required String issuerId,
    @required String emailCustomer,
    @required String cardToken,
    @required Order order,
  }) async {

    try {

      final url = Uri.http(_url, '/api/payments/createPay');

      Map<String, dynamic> body = {
        'order': order,
        'card_id': cardId,
        'description': 'my app food',
        'transaction_amount': transactionAmount,
        'installments': installments,
        'payment_method_id': paymentMethodId,
        'token': cardToken,
        'issuer_id': issuerId,
        'payer': {
          'email': emailCustomer,
        }
      };

      print('PARAMS: ${body}');

      String bodyParams = json.encode(body);

      Map<String, String> headers = {
        'Content-type': 'application/json',
        'Authorization': user.sessionToken
      };

      final res = await http.post(url, headers: headers, body: bodyParams);

      if (res.statusCode == 401) {
        Fluttertoast.showToast(msg: 'Sesion expirada');
        new SharedPref().logout(context, user.id);
        return null;
      }

      return res;

    } catch(e) {

      print('Error: $e');
      return null;
    }
  }

  Future<MercadoPagoPaymentMethodInstallments> getInstallments(String bin, double amount) async {

    try {
      final url = Uri.https(_urlMercadoPago, '/v1/payment_methods/installments', {
        'access_token': _mercadoPagoCredentials.accessToken,
        'bin': bin,
        'amount': '${amount}'
      });

      final res = await http.get(url);
      final data = json.decode(res.body);
      print('DATA INSTALLMENTS: $data');

      final result = new MercadoPagoPaymentMethodInstallments.fromJsonList(data);

      return result.installmentList.first;
    } catch(e) {
      print('Error: $e');
      return null;
    }

  }

  Future<http.Response> createCardToken({
    String cvv,
    String expirationYear,
    int expirationMonth,
    String cardNumber,
    String documentNumber,
    String documentId,
    String cardHolderName,
  }) async {
    try {

      final url = Uri.https(_urlMercadoPago, '/v1/card_tokens', {
        'public_key': _mercadoPagoCredentials.publicKey
      });

      final body = {
        'security_code': cvv,
        'expiration_year': expirationYear,
        'expiration_month': expirationMonth,
        'card_number': cardNumber,
        'cardholder': {
          'identification' : {
            'number': documentNumber,
            'type': documentId,
          },
          'name': cardHolderName
        },
      };

      final res = await http.post(url, body: json.encode(body));

      return res;

    } catch(e) {
      print('Error: $e');
      return null;
    }

  }


}