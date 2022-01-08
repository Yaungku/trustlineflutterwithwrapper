import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:trustlinesflutterwithwrapper/models/models.dart';
import 'package:trustlinesflutterwithwrapper/services/respository.dart';

part 'api_event.dart';
part 'api_state.dart';

class ApiBloc extends Bloc<ApiEvent, ApiState> {
  ApiBloc() : super(ApiInit()) {
    on<ApiGetNetwork>(getNetworkState);
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
}
