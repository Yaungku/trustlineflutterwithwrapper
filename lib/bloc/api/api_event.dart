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
