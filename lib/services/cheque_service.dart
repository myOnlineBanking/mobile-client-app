import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:app_for_test/models/Cheque.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;

class ChequeService {
  final String getAccountsOfClientUrl =
      "http://192.168.43.193:8081/ebank/clientService/Client/chequesOfClient/";

  Future getChequesOfClient(clientId) async {
    var response =
        await http.get(Uri.parse(getAccountsOfClientUrl + clientId.toString()));
    if (response.statusCode == 200) {
      List<Cheque> clientCheques = List.empty(growable: true);
      Cheque cheque;
      for (var item in json.decode(response.body)) {
        cheque = Cheque();
        cheque.id = item['id'].toString();
        cheque.reference = item['reference'].toString();
        cheque.currency = item['currency'];
        cheque.amount = item['amount'];
        cheque.creationDate = item['creationDate'];
        cheque.creationTime = item['creationTime'];
        cheque.direction = item['direction'];
        clientCheques.add(cheque);
      }
      print(clientCheques);
      return clientCheques;
    } else {
      return null;
    }
  }
}
