import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecase/post_contactUs_use_case.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit(this.postContactUsUseCase) : super(ContactUsInitial());
  static ContactUsCubit get(context) => BlocProvider.of(context);

  PostContactUsUseCase postContactUsUseCase;
  Future<void> addTicket({
    required String title,
    required String phone,
    required String comment,
    required String email,
    required bool statues,
    required String fullName,
  }) async {
    emit(ContactUsSendLoading());
    final result = await postContactUsUseCase(TicketParameters(
      title: title,
      phone: phone,
      comment: comment,
      email: email,
      statues: statues,
      fullName: fullName,
    ));
    result.fold(
      (l) => emit(ContactUsSendError()),
      (r) => emit(ContactUsSendSuccess()),
    );
  }
}
