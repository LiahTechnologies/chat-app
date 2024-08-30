

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/features/ballots/domain/usecases/ballots-usecase.dart';
import 'package:njadia/src/features/ballots/presentation/bloc/ballot-event.dart';
import 'package:njadia/src/features/ballots/presentation/bloc/ballot-state.dart';

class BallotBloc extends Bloc<BallotEvent, BallotState>{
  final BallotUsecase ballotUsecase;
  BallotBloc({required this.ballotUsecase}):super(InitBallotState()){



    on<OnFetchBallots>((event,emit)async{
        final result = await ballotUsecase.fetchBallots(groupId: event.groupId, uid: event.uid);
        result.fold((l)=>emit(BallotError()), (data)=>emit(BallotsLoaded(ballots: data)));
    });



    on<OnGenerateBallots>((event,emit)async{
        final result =await ballotUsecase.generateBallots(groupId: event.groupId);
        result.fold((l)=>emit(BallotError()), (data)=>emit(BallotGenerated()));
    });




  }
}