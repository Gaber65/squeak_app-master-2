import 'package:equatable/equatable.dart';

class TripModel extends Equatable {
  final String details;
  final String flightName;
  final String hotailName;
  final String numOfMember;
  final String image;
  final String location;
  final List<dynamic> listOfImage;
  final String price;
  final dynamic rating;

  Map<String, dynamic> toMap() {
    return {
      'details': details,
      'flightName': flightName,
      'hotailName': hotailName,
      'numOfMember': numOfMember,
      'location': location,
      'image': image,
      'listOfImage': listOfImage,
      'price': price,
      'rating': rating,
    };
  }

  const TripModel({
    required this.details,
    required this.flightName,
    required this.price,
    required this.rating,
    required this.hotailName,
    required this.listOfImage,
    required this.location,
    required this.numOfMember,
    required this.image,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      details: json['details'],
      flightName: json['flightName'],
      price: json['price'],
      rating: json['rating'],
      hotailName: json['hotailName'],
      numOfMember: json['numOfMember'],
      listOfImage:json['listOfImage'],
      location: json['location'],
      image: json['image'],
    );
  }

  @override
  List<Object> get props => [
        details,
        flightName,
        hotailName,
        numOfMember,
        location,
        listOfImage,
        price,
        rating,
        image,
      ];
}
