
abstract class SettingState {}

class SettingInitial extends SettingState {}


///todo GetUserdata
class SuccessGetUserdata extends SettingState {}
class ErrorGetUserdata extends SettingState {}
class LoadingGetUserdata extends SettingState {}

///todo UpdateUserdata
class UpdateLoadingUserDataState extends SettingState{}
class UpdateSuccessUserDataState extends SettingState{}
class UpdateErrorUserDataState extends SettingState{}


///todo pickImage
class ImagePostSuccess extends SettingState{}
class ImagePostError extends SettingState{}
