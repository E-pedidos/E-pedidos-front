import 'package:e_pedidos_front/models/filial_model.dart';

abstract class FilialState {
  final List<FilialModel> filiais;
  final int? statusCode;

  FilialState({required this.filiais, this.statusCode});
} 

class FilialInitialState extends FilialState {
  FilialInitialState(): super(filiais: []);
}

class FilialLoadingState extends FilialState {
  FilialLoadingState(): super(filiais: []);
}

class FilialLoadedState extends FilialState {
  FilialLoadedState({required List<FilialModel> filiais}): super(filiais: filiais);
}

class FilialErrorState extends FilialState {
  final Exception exception;
  FilialErrorState({required this.exception}): super(filiais: []);
}