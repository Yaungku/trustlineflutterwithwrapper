part of 'api_bloc.dart';

abstract class ApiEvent extends Equatable {
  const ApiEvent();

  @override
  List<Object> get props => [];
}

class ApiGetNetwork extends ApiEvent {}

class ApiCreateWallet extends ApiEvent {}

class ApiGetEvents extends ApiEvent {
  final Wallet wallet;

  const ApiGetEvents({required this.wallet});

  @override
  List<Object> get props => [wallet];
}

class ApiGetOverview extends ApiEvent {
  final Wallet wallet;
  final Network network;

  const ApiGetOverview({required this.wallet, required this.network});

  @override
  List<Object> get props => [wallet, network];
}

class ApiRecoverFromSeed extends ApiEvent {
  final String seed;

  const ApiRecoverFromSeed({required this.seed});

  @override
  List<Object> get props => [seed];
}

class ApiRecoverFromPrivateKey extends ApiEvent {
  final String privateKey;

  const ApiRecoverFromPrivateKey({required this.privateKey});

  @override
  List<Object> get props => [privateKey];
}

class ApiTransfer extends ApiEvent {
  final Transfer data;

  const ApiTransfer({required this.data});

  @override
  List<Object> get props => [data];
}

class ApiAcceptTrustline extends ApiEvent {
  final CreditLine data;

  const ApiAcceptTrustline({required this.data});

  @override
  List<Object> get props => [data];
}

class ApiUpdateTrustline extends ApiEvent {
  final CreditLine data;

  const ApiUpdateTrustline({required this.data});

  @override
  List<Object> get props => [data];
}
