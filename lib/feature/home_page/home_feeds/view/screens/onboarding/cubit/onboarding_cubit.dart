import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(OnboardingInitial());
  static OnboardingCubit get(context) => BlocProvider.of(context);

  double value = 1/3 ;

  bool isLastPage = false;
  bool isClick = false;

  void listenPageLastIndex(bool isLast) {
    isLastPage = isLast;
    emit(ChangePageLastIndexState());
  }

}
