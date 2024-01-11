import 'package:bloc/bloc.dart';
import 'package:e_pedidos_front/blocs/filialBlocs/filial_event.dart';
import 'package:e_pedidos_front/blocs/filialBlocs/filial_state.dart';
import 'package:e_pedidos_front/models/filial_model.dart';
import 'package:e_pedidos_front/repositorys/filial_repository.dart';

class FilialBloc extends Bloc<FilialEvent, FilialState> {
  final _filialRepository = FilialRepository();

  FilialBloc() : super(FilialInitialState()) {
    on(_mapEventToState);
  }

  void _mapEventToState(FilialEvent event, Emitter emit) async {
    List<FilialModel> filiais = [];
    dynamic statusCode;

    emit(FilialLoadingState());

    if (event is GetFilial) {
      var res = await _filialRepository.getFilials();
      
      if(res is List<FilialModel>){
        filiais = res;
      } else{
        filiais = [];
      }
    }

    if (event is RegisterFilial) {
      var res = await _filialRepository.registerFilial(event.name, event.address);
      statusCode = res.statusCode;

      if (statusCode == 201) {
        filiais = await _filialRepository.getFilials();
      }
    }

    if (event is UpdateFilial) {
      var res = await _filialRepository.updateFilial(event.name, event.address, event.id);
      statusCode = res.statusCode;

      if (statusCode == 202) {
        filiais = await _filialRepository.getFilials();
      }
    }

    if (event is DeleteFilial) {
      statusCode = await _filialRepository.deleteFilial(event.id);
      if (statusCode == 204) {
        filiais = await _filialRepository.getFilials();
      }
    }

    emit(FilialLoadedState(filiais: filiais));
  }
}
