import 'package:e_pedidos_front/models/filial_model.dart';

abstract class FilialEvent {}

class GetFilial extends FilialEvent{

}

class PostFilial extends FilialEvent{
  final FilialModel filial;

  PostFilial({required this.filial});
}

class RegisterFilial extends FilialEvent {
  final String name;
  final String address;

  RegisterFilial({required this.name, required this.address});
}

class UpdateFilial extends FilialEvent {
  final String name;
  final String address;
  final String id;

  UpdateFilial({required this.name, required this.address, required this.id});
}

class DeleteFilial extends FilialEvent{
  final String id;

  DeleteFilial({required this.id});
}

class ShowSnackBar extends FilialEvent {
  final String message;

  ShowSnackBar(this.message);
}