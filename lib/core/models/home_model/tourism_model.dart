import 'package:equatable/equatable.dart';

class TourismModel extends Equatable {
  final String flightName;
  final String image;
  final dynamic location;

  Map<String, dynamic> toMap() {
    return {
      'flightName': flightName,
      'location': location,
      'image': image,

    };
  }

  const TourismModel({
    required this.flightName,
    required this.location,
    required this.image,
  });

  factory TourismModel.fromJson(Map<String, dynamic> json) {
    return TourismModel(
      flightName: json['flightName'],
      location: json['location'],
      image: json['image'],
    );
  }



  @override
  List<Object> get props => [flightName, image, location];
}
