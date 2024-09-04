

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:njadia/src/features/profile/presentation/bloc/profile-event.dart';
import 'package:njadia/src/features/profile/presentation/bloc/profile-state.dart';
import 'package:njadia/src/features/profile/presentation/views/profile.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState>{
  ProfileBloc():super(DefaultProfile()){
    
  }
}