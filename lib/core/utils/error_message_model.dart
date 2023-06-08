import 'package:equatable/equatable.dart';

class StatusErrorMessageModel extends Equatable
{
  final String error;
  final String message;
  final int code;

 const StatusErrorMessageModel({
   required this.error,
   required this.message,
   required this.code,
 });

 factory StatusErrorMessageModel.fromJson(Map<String,dynamic>json)
 {
   return StatusErrorMessageModel(
     error: json['error'],
     message: json['message'],
     code: json['code'],
   );
 }
  @override
  List<Object?> get props => [
    error,
    message,
    code,
  ];
}