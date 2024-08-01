import 'package:dartz/dartz.dart';
import 'package:njadia/src/core/common/errors/failures.dart';
import 'package:njadia/src/features/payment/domain/entity/send-money-entity.dart';

abstract class SendMoneyRepository{
  Future<Either<Failure,bool>> sendMoney({required SendMoneyEntity SendMoneyEntity});
}