import 'package:trustlinesflutterwithwrapper/models/models.dart';

class Event {
  String? blockHash;
  Balance? interestRateGiven;
  Balance? interestRateReceived;
  Balance? given;
  Balance? received;
  String? transitionId;
  String? counterParty;
  String? status;
  String? type;
  bool? isfrozen;
  String? from;
  String? to;
  int? timestamp;
  String? transitionhash;
  String? user;
  String? extraData;
  String? networkAddress;
  int? logIndex;
  Balance? transfer;
  int? blockNumber;
  String? direction;

  Event.fromJson(Map<String, dynamic> json)
      : blockHash = json['blockHash'],
        interestRateGiven = json['interestRateGiven'] == null
            ? null
            : Balance?.fromJson(json['interestRateGiven']),
        interestRateReceived = json['interestRateReceived'] == null
            ? null
            : Balance?.fromJson(json['interestRateReceived']),
        given = json["given"] == null ? null : Balance?.fromJson(json['given']),
        received = json["received"] == null
            ? null
            : Balance?.fromJson(json['received']),
        transitionId = json['transactionId'],
        counterParty = json['counterParty'],
        status = json['status'],
        type = json['type'],
        isfrozen = json['isFrozen'],
        from = json['from'],
        to = json['to'],
        timestamp = json['timestamp'],
        transitionhash = json['transactionHash'],
        user = json['user'],
        extraData = json['extraData'],
        networkAddress = json['networkAddress'],
        logIndex = json['logIndex'],
        transfer = json['transfer'] == null
            ? null
            : Balance?.fromJson(json['transfer']),
        blockNumber = json['blockNumber'],
        direction = json['direction'];
}
