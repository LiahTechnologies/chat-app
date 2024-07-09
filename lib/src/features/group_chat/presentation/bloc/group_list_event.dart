import 'package:equatable/equatable.dart';

class GroupListEvent extends Equatable {
  GroupListEvent();

 
  @override
  List<Object?> get props => [];
}



class OnGroupsFetch extends GroupListEvent {
   final String groupId;
  OnGroupsFetch({required this.groupId});

   @override
  List<Object?> get props => [groupId];
 
}

class OnGroupDelete extends GroupListEvent {
   final String error;
  OnGroupDelete({required this.error});

   @override
  List<Object?> get props => [error];
}
