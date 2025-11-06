import 'package:equatable/equatable.dart';

class HajjAndUmrahModel extends Equatable {
  final String endData;
  final String image;
  final String name;
  final String price;
  final String rating;
  final String startDate;

  Map<String, dynamic> toMap() {
    return {
      'flightName': name,
      'endData': endData,
      'price': price,
      'rating': rating,
      'startDate': startDate,
      'image': image,
    };
  }

  const HajjAndUmrahModel({
    required this.name,
    required this.endData,
    required this.price,
    required this.rating,
    required this.startDate,
    required this.image,
  });

  factory HajjAndUmrahModel.fromJson(Map<String, dynamic> json) {
    return HajjAndUmrahModel(
      name: json['flightName'],
      endData: json['enddate'],
      price: json['price'],
      rating: json['rating'],
      image: json['image'],
      startDate: json['startdate'],
    );
  }

  @override
  List<Object> get props => [
        endData,
        image,
        name,
        price,
        rating,
        startDate,
      ];
}
