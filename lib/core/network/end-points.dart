
const String baseApiUrl = 'http://squeak-001-site1.atempurl.com';
const String version = '/api';
const String registerEndPoint = '/Owners/RegisterUsers';
const String registerAsADoctorEndPoint = '/Owners/RegisterUsers';
const String loginEndPoint = '/Owners/Login';
String verificationCodeEndPoint(String verificationToken) => '/Owners/Verified?token=$verificationToken';
String forgetPasswordEndPoint(String email) => '/Owners/Forget-Password?email=$email';
const String resetPasswordEndPoint = '/Owners/reset-Password';
const String profileEndPoint = '/Owners/FindUserById';
const String updateProfileEndPoint = '/Owners/updateOwners';
const String addPets = '/Pets/AddPet';

const String findPitsOwner = '/Pets/FindPetByOwnerId';
const String GetBreedsUrl = '${baseApiUrl}${version}/Pets/GetBreeds';
const String GetpetByIdUrl = 'http://squeak-001-site1.atempurl.com/api/Pets/FindpetsById';
const String FindPetByOwnerIdUrl = 'http://squeak-001-site1.atempurl.com/api/Pets/FindPetByOwnerId';
const String AddBreedsUrl = 'http://squeak-001-site1.atempurl.com/api/Pets/AddPet';
const String EditBreedsUrl = 'http://squeak-001-site1.atempurl.com/api/Pets/updatepetsById?petid=';


// const String loginEndPoint = '/login';
// const String profileEndPoint = '/profile';
// const String homeEndPoint = '/home';
// const String categoriesEndPoint = '/categories';
// const String updateProfileEndPoint = '/update-profile';
// const String searchEndPoint = '/products/search';
// const String changeFavoritesEndPoint = '/favorites';
// const String favoritesEndPoint = '/favorites';
// String categoriesDetailsEndPoint(int categoriesId)=> '/categories/$categoriesId';
//
// String productsDetailsEndPoint(int productsId)=>'/products/$productsId';
//


 String? token = '';
 late String language ;