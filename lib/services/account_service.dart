import 'dart:convert';
import 'dart:math';

import 'package:app_for_test/models/Account.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:app_for_test/shared/Constants.dart' as constants;

class AccountService {
  Future<List<Account>> getAccountsOfClient(clientId) async {
    print("URL ; " +
        Uri.parse(constants.GET_ACCOUNTS_OF_CLIENT +
                "?userId=" +
                clientId.toString())
            .toString());
    var response = await http.get(Uri.parse(
        constants.GET_ACCOUNTS_OF_CLIENT + "?userId=" + clientId.toString()));
    if (response.statusCode == 200) {
      List<Account> clientAccounts = List.empty(growable: true);
      Account account = Account();
      for (var item in json.decode(response.body)) {
        account = Account();

        account.id = item['id'].toString();
        account.accountNumber = item['accountNumber'].toString();
        account.balance = item['balance'];
        account.creationDate = item['creationDate'];
        account.currency = item['currency'];
        account.type = item['type'];
        account.isEnabled = item['enabled'];

        clientAccounts.add(account);
      }

      print("clientAccounts.length:" + clientAccounts.length.toString());
      print(clientAccounts
          .map((e) => e.id.toString() + " " + e.accountNumber.toString()));

      return clientAccounts;
    } else {
      return [];
    }
  }

  Future<Account> requestNewAccount(clientId, data) async {
    var payload = json.encode({
      "accepted": false,
      "accountNumber": generateRandomString(7),
      "balance": 0,
      "creationDate": "2022-01-01T21:08:33.022Z",
      "currency": data['currency'],
      "deleted": false,
      "enabled": false,
      "type": data['type'],
      "userId": clientId
    });

    var response = await http.post(
      Uri.parse(constants.REQUEST_NEW_ACCOUNT_URL),
      body: payload,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      print(
          "Request Account Succeded \n -----------------------------------------------------------------");
      print(response.body);
    } else {
      print(
          "Request Account Failed \n *******************************************************************");
      print(response.body);
    }
    return new Account();
  }

  String generateRandomString(int length) {
    final _random = Random();
    const _availableChars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    final randomString = List.generate(length,
            (index) => _availableChars[_random.nextInt(_availableChars.length)])
        .join();

    return randomString;
  }
}
