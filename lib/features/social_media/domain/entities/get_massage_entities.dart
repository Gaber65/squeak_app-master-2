import 'package:equatable/equatable.dart';

import 'create_message_entities.dart';

class GetMassageEntities extends Equatable {
   List<CreateMessageData>? massages;
   dynamic state;
   Map<String, List<dynamic>>? errors;

   GetMassageEntities({
     this.massages,
     this.state,
     this.errors,
  });

  @override
  List<Object?> get props => [massages, errors, state];
}
