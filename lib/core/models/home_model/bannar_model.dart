import 'package:equatable/equatable.dart';

class BannarModel extends Equatable {
  final String bannerImage;

  const BannarModel({
    required this.bannerImage,
  });

  @override
  List<Object> get props => [
        bannerImage,
      ];
  factory BannarModel.fromJson(Map<String, dynamic> json) {
    return BannarModel(
      bannerImage: json['image'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'image': bannerImage,
    };
  }
}
