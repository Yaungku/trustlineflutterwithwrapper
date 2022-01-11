part of 'api_bloc.dart';

abstract class ApiState extends Equatable {
  const ApiState();

  @override
  List<Object> get props => [];
}

class ApiInit extends ApiState {}

class ApiSuccess extends ApiState {}

class ApiLoading extends ApiState {}

class ApiWalletData extends ApiState {
  final Wallet data;
  const ApiWalletData({required this.data});

  @override
  List<Object> get props => [data];
}

class ApiNetworkData extends ApiState {
  final List<Network> data;
  const ApiNetworkData({required this.data});

  @override
  List<Object> get props => [data];
}

class ApiOverviewData extends ApiState {
  final UserOverview data;
  const ApiOverviewData({required this.data});

  @override
  List<Object> get props => [data];
}

class ApiFail extends ApiState {
  final String error;

  const ApiFail({required this.error});

  @override
  List<Object> get props => [error];
}
