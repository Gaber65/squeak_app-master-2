import 'package:squeak/core/network/dio_helper.dart';
import 'package:squeak/core/network/end-points.dart';
import 'package:squeak/features/layout/profile/data/model/profile_model.dart';
import 'package:http/http.dart' as http;

import '../../domain/usecase/get_breeds_use_case.dart';
import '../../domain/usecase/post_pets_use_case.dart';
import '../../domain/usecase/update_pits_use_case.dart';
import '../model/owner_pets_model.dart';
import '../model/pets_model.dart';
import '../model/species_model.dart';

abstract class BaseProfileRemoteDataSource {
  Future<ProfileModel> getProfile();

  Future<PetsModel> postPetsBaseDataSource(PostPetsParameters parameters);
  Future<PetsModel> upDatePetsBaseDataSource(UpdatePetsParameters parameters);

  Future<SpeciesModel> getBreedBaseDataSource(GetBreedParameters parameters);

  Future<OwnerPetsEntitiesModel> getOwnerPetsBaseDataSource();
}

class ProfileRemoteDataSource extends BaseProfileRemoteDataSource {
  final DioHelper dioHelper;

  ProfileRemoteDataSource(this.dioHelper);

  @override
  Future<ProfileModel> getProfile() async {
    final response = await dioHelper.get(
      endPoint: profileEndPoint,
      lang: language,
    );

    return ProfileModel.fromJson(response);
  }

  @override
  Future<PetsModel> postPetsBaseDataSource(
      PostPetsParameters parameters) async {
    var headers = {
      'content-type': 'application/problem+json',
      'Authorization': token!,
      'lang': language,
    };
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
        'http://squeak-001-site1.atempurl.com/api/Pets/AddPet',
      ),
    );
    request.fields.addAll({
      'PetName': parameters.petName,
      'Gender': parameters.gender.toString(),
      'species': parameters.species.toString(),
      'Breedid': parameters.breedId,
      'Birthdate': parameters.birthdate,
      'imageName': parameters.imageName,
      'ownerClientId': token!,
    });
    request.files.add(
      await http.MultipartFile.fromPath('image', parameters.image.path),
    );
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return PetsModel.fromJson(request as Map<String, dynamic>);
  }

  @override
  Future<SpeciesModel> getBreedBaseDataSource(
      GetBreedParameters parameters) async {
    var headers = {
      'content-type': 'application/problem+json',
      'Authorization': token!,
      'lang': language,
    };
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'http://squeak-001-site1.atempurl.com/api/Pets/GetBreeds?speciesId=${parameters.speciesId}'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return SpeciesModel.fromJson(request as Map<String, dynamic>);
  }

  @override
  Future<OwnerPetsEntitiesModel> getOwnerPetsBaseDataSource() async {
    final response = await dioHelper.get(
        endPoint: findPitsOwner, lang: language, Authorization: token);

    return OwnerPetsEntitiesModel.fromJson(response);
  }

  @override
  Future<PetsModel> upDatePetsBaseDataSource(
      UpdatePetsParameters parameters) async {
    var headers = {
      'content-type': 'application/problem+json',
      'Authorization': token!,
      'lang': language,
    };
    var request = http.MultipartRequest(
        'PUT',
        Uri.parse(
            'http://squeak-001-site1.atempurl.com/api/Pets/updatepetsById?petid=${parameters.petId}'));
    request.fields.addAll({
      'PetName': parameters.petName,
      'birthdate': parameters.birthdate,
      'species': '${parameters.species}',
      'gender': '${parameters.gender}'
    });
    request.files
        .add(await http.MultipartFile.fromPath('image', parameters.image.path));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
    return PetsModel.fromJson(request as Map<String, dynamic>);
  }
}
