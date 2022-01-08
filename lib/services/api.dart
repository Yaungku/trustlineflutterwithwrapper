String networkurl = "https://tl-clientlib-wrapper-api.herokuapp.com/";
String localhost = "https://10.0.2.2:8000/";

var baseUrl = networkurl;

class Api {
  static var accepttrustline = baseUrl + "trustline/accept";
  static var createwallet = baseUrl + "user";
  static var currencynetworks = baseUrl + "network";
  static var events = baseUrl + "event";
  static var recoverfromprivatekey = baseUrl + "user/recoverFromPrivateKey";
  static var recoverfromseed = baseUrl + "user/recoverFromSeed";
  static var transfer = baseUrl + "payment";
  static var useroverview = baseUrl + "network/user";
}

var globalheader = {
  "Content-Type": "application/json",
};
