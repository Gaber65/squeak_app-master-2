import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/service/service_locator.dart';

class Constants {

  void signOut(context)async
  {
    sl<SharedPreferences>().remove('token').then((value)
    {
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen(),),);
    });
  }
}