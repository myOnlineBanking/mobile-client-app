import 'dart:convert';

// ignore: import_of_legacy_library_into_null_safe
import 'package:app_for_test/models/Client.dart';
import 'package:app_for_test/models/Recipient.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:http/http.dart' as http;
import 'package:app_for_test/shared/Constants.dart' as constants;

class ClientService {
  Future<Client> getClientInfo(clientId) async {
    print("Url:" +
        Uri.parse(constants.GET_CLIENT_INFO_URL + clientId).toString());
    var response =
        await http.get(Uri.parse(constants.GET_CLIENT_INFO_URL + clientId));
    if (response.statusCode == 200) {
      var body = json.decode(response.body);
      Client client = Client();
      client.id = body['id'].toString();
      //client.accounts = body['accounts'];
      client.address = body['address'];
      client.agencyId = body['agencyId'];
      client.birthday = body['birthday'];
      client.cin = body['cin'];
      client.email = body['email'];
      client.enabled = body['enabled'];
      client.deleted = body['deleted'];
      client.username = body['username'];
      client.firstname = body['firstname'];
      client.lastname = body['lastname'];
      client.phone = body['phone'];

      return client;
    } else {
      return new Client();
    }
  }

  Future<List<Recipient>> getRecipients(clientId) async {
    var response = await http
        .get(Uri.parse(constants.GET_CLIENT_RECIPIENTS_URL + clientId));

    if (response.statusCode == 200) {
      List<Recipient> recipients = List.empty(growable: true);
      Recipient recipient = Recipient();
      for (var item in json.decode(response.body)) {
        recipient = Recipient();

        recipient.accountNumber = item['accountNumber'].toString();
        recipient.email = item['email'].toString();
        recipient.groupName = item['groupName'];
        recipient.name = item['name'];
        recipient.phone = item['phone'];
        recipient.salary = item['salary'];

        recipients.add(recipient);
      }

      print("clientRecipients.length:" + recipients.length.toString());
      print(recipients.map(
          (e) => e.accountNumber.toString() + " " + e.groupName.toString()));

      return recipients;
    } else {
      return [];
    }
  }

  Future<Recipient> addNewRecipient(recipient) async {
    print(recipient);

    var payload = json.encode({
      "accountNumber": recipient['accountNumber'],
      "email": recipient['email'],
      "groupName": recipient['groupName'],
      "name": recipient['name'],
      "phone": recipient['phone'],
      "salary": recipient['salary'],
      "userId": recipient['userId']
    });

    var response = await http.post(
      Uri.parse(constants.ADD_RECIPIENT_URL),
      body: payload,
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      print(
          "ADD RECIPIENT Succeded \n -----------------------------------------------------------------");
      print(response.body);
    } else {
      print(
          "ADD RECIPIENT Failed \n *******************************************************************");
      print(response.body);
    }
    return new Recipient();
  }

  Set<String> recipientsGroups(List<Recipient>? recipients) {
    Set<String> groups = new Set<String>();
    groups.add("Default");
    recipients?.forEach((element) {
      groups.add(element.groupName.toString());
    });
    return groups;
  }
}
