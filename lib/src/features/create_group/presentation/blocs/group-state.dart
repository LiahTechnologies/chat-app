
import 'package:equatable/equatable.dart';

class GroupState extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}

class GroupEmpty extends GroupState{}
class GroupCreated extends GroupState{}
class Error extends GroupState{}