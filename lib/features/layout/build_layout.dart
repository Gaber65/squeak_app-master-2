// import 'dart:async';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
// import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_state.dart';
// import '../../core/network/dio.dart';
// import '../../core/network/end-points.dart';
// import '../../core/network/helper/helper_model/refresh_model.dart';
// import '../../core/service/service_locator.dart';
// import '../../core/widgets/components/hub_connection.dart';
// import '../../core/widgets/components/styles.dart';
// import '../social_media/presentation/components/chat_hub_connection.dart';
// import 'layout.dart';
//
// class BuildHomeLayout extends StatefulWidget {
//   const BuildHomeLayout({Key? key}) : super(key: key);
//
//   @override
//   State<BuildHomeLayout> createState() => _BuildHomeLayoutState();
// }
//
// class _BuildHomeLayoutState extends State<BuildHomeLayout> {
//
//   @override
//   void initState() {
//     Timer.periodic(const Duration(days: 4), (timer) async{
//       DioFinalHelper.postData(
//         method: '$version$loginEndPoint',
//         data: {
//           "emailOrUsername": sl<SharedPreferences>().getString('email'),
//           "Password": sl<SharedPreferences>().get('password')
//         },
//       ).then(
//             (value) {
//           RefreshToken model = RefreshToken.fromJson(value.data);
//           print(value.data);
//           token == '';
//           refreshToken = '';
//           sl<SharedPreferences>().remove('token');
//           sl<SharedPreferences>().remove('refreshToken');
//           sl<SharedPreferences>().setString('token', model.data.token);
//           sl<SharedPreferences>()
//               .setString('refreshToken', model.data.refreshToken)
//               .then(
//                 (value) {
//               token = model.data.token;
//               refreshToken = model.data.refreshToken;
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => const LayoutScreen(),
//                 ),
//                     (route) => false,
//               );
//             },
//           );
//         },
//       ).catchError(
//             (onError) {
//           print(onError.toString());
//         },
//       );
//     });
//     FirebaseMessaging.instance.requestPermission(
//       alert: true,
//       sound: true,
//     );
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => sl<SqueakCubit>()..getOwnerPits()..getProfile(),
//       child: BlocConsumer<SqueakCubit, SqueakState>(
//         listener: (context, state) async {
//           if (SqueakCubit.get(context).profile != null && SqueakCubit.get(context).ownerPetsEntities != null) {
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const LayoutScreen(),
//               ),
//               (route) => false,
//             );
//             await MyAppNotifications().initPlatformDartServer();
//             await ChatNotifications().initPlatformDartServer();
//           }
//         },
//         builder: (context, state) {
//           var cubit = SqueakCubit.get(context);
//           return DefaultTabController(
//             length: 4,
//             child: Scaffold(
//               appBar: AppBar(),
//               bottomNavigationBar: TabBar(
//                 unselectedLabelColor: Colors.grey,
//                 labelColor: appColorBtn,
//                 tabs: cubit.items,
//               ),
//               body: const Center(child: CircularProgressIndicator()),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
