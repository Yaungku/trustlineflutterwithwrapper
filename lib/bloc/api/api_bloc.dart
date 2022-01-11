import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trustlinesflutterwithwrapper/models/models.dart';
import 'package:trustlinesflutterwithwrapper/services/respository.dart';
import 'package:trustlinesflutterwithwrapper/services/storage.dart';
import 'package:trustlinesflutterwithwrapper/ui/constants.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInit()) {
    on<ApiGetNetwork>(getNetworkState);
    on<ApiCreateWallet>(createWalletState);
    on<ApiGetOverview>(getUserOverviewState);
  }

  Future getNetworkState(ApiGetNetwork event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      var response = await Respository.getnetworks();
      List<Network> data = (jsonDecode(response) as List)
          .map((i) => Network.fromJson(i))
          .toList();

      emit(ApiNetworkData(data: data));
    } catch (e) {
      emit(ApiFail(error: e.toString()));
    }
  }

  Future createWalletState(
      ApiCreateWallet event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      // await Future.delayed(const Duration(seconds: 2));
      var response = await Respository.createWallet();
      Wallet data = Wallet.fromJson(jsonDecode(response));
      Storage.prefs!.setString(cpublickey, data.address!);
      Storage.prefs!.setString(cprivatekey, data.keys!.privatekey!);
      Storage.prefs!.setString(cseed, data.keys!.mnemonic!);
      Storage.prefs!.setString(ctype, data.type!);
      Storage.prefs!.setInt(cversion, data.version!);

      emit(ApiWalletData(data: data));
    } catch (e) {
      emit(ApiFail(error: e.toString()));
    }
  }

  Future getAccountEventsState(
      ApiGetEvents event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      var response = await Respository.getEvents(event.wallet);

      emit(ApiSuccess());
    } catch (e) {
      emit(ApiFail(error: e.toString()));
    }
  }

  Future getUserOverviewState(
      ApiGetOverview event, Emitter<ApiState> emit) async {
    emit(ApiLoading());
    try {
      var response =
          await Respository.getuserOverview(event.wallet, event.network);
      UserOverview data = UserOverview.fromJson(jsonDecode(response));
      emit(ApiOverviewData(data: data));
    } catch (e) {
      emit(ApiFail(error: e.toString()));
    }
  }
}
