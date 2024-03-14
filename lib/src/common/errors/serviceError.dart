import 'package:equatable/equatable.dart';

class ServiceFailure extends Equatable {
  final String message;

  ServiceFailure(this.message);
  
  @override
  // TODO: implement props
  List<Object?> get props => [message];
  
}



class ServerFailure extends ServiceFailure{
  ServerFailure(super.message);

}
