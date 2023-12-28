import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:e_pedidos_front/blocs/filialBlocs/filial_event.dart';
import 'package:e_pedidos_front/blocs/filialBlocs/filial_state.dart';
import 'package:e_pedidos_front/models/filial_model.dart';
import 'package:e_pedidos_front/repositorys/filial_repository.dart';

class FilialBloc extends Bloc<FilialEvent, FilialState>{
  final _filialRepository = FilialRepository();
  final GlobalKey<ScaffoldMessengerState> scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  FilialBloc(): super(FilialInitialState()) {
    on(_mapEventToState);
  }

  void _mapEventToState(FilialEvent event, Emitter emit) async {
    List<FilialModel> filiais = [];
    int statusCode;

    emit(FilialLoadingState());

    if (event is GetFilial) {
      filiais = await _filialRepository.getFilials();
    }
    if (event is RegisterFilial) {
      statusCode =
          await _filialRepository.registerFilial(event.name, event.address);
      if (statusCode == 201) {
        emit(ShowSnackBar('Filial criada com sucesso!'));
        filiais = await _filialRepository.getFilials();
      } else {
        emit(ShowSnackBar('Erro ao cadastrar a filial'));
      }
    }
    if (event is DeleteFilial) {
      statusCode = await _filialRepository.deleteFilial(event.id);
    }

    emit(FilialLoadedState(filiais: filiais));
  }

}
