import 'package:equatable/equatable.dart';

class HotailModel extends Equatable {
  final Map accompanying;
  final List<dynamic> lounges;
  final List<dynamic> parking;
  final List<dynamic> reception;
  final List<dynamic> restaurant;
  final List<dynamic> rooms;
  final int numOfRating;

  const HotailModel({
    required this.accompanying,
    required this.lounges,
    required this.parking,
    required this.reception,
    required this.restaurant,
    required this.rooms,
    required this.numOfRating,
  });
  factory HotailModel.fromJson(Map<String, dynamic> json) {
    return HotailModel(
      accompanying: json['Accompanying'],
      lounges: json['lounges'],
      parking: json['parking'],
      reception: json['reception'],
      restaurant: json['restaurant'],
      rooms: json['rooms'],
      numOfRating: json['numOfRating'],
    );
  }
  @override
  List<Object> get props => [
        accompanying,
        lounges,
        parking,
        reception,
        restaurant,
        rooms,
        numOfRating,
      ];
}
