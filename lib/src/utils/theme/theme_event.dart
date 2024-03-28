import 'package:equatable/equatable.dart';

 class ThemeEvent extends Equatable{
  @override
  // TODO: implement props
  List<Object?> get props => [];

  
}

class OnThemeChange extends ThemeEvent {
 
  final bool isDark;

  OnThemeChange( this.isDark);

}
