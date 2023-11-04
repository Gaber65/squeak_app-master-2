// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Email Address`
  String get email {
    return Intl.message(
      'Email Address',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email address`
  String get enterUrEmail {
    return Intl.message(
      'Please enter your email address',
      name: 'enterUrEmail',
      desc: '',
      args: [],
    );
  }

  /// `Check Your Email`
  String get checkYourEmail {
    return Intl.message(
      'Check Your Email',
      name: 'checkYourEmail',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email to receive the instruction to reset your password`
  String get receiveEmail {
    return Intl.message(
      'Please enter your email to receive the instruction to reset your password',
      name: 'receiveEmail',
      desc: '',
      args: [],
    );
  }

  /// `Send me now`
  String get sendMeNow {
    return Intl.message(
      'Send me now',
      name: 'sendMeNow',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get enterUrPassword {
    return Intl.message(
      'Please enter your password',
      name: 'enterUrPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your address`
  String get enterUrAddress {
    return Intl.message(
      'Please enter your address',
      name: 'enterUrAddress',
      desc: '',
      args: [],
    );
  }

  /// `Password more than 6 charts`
  String get enterCharPassword {
    return Intl.message(
      'Password more than 6 charts',
      name: 'enterCharPassword',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get changePassword {
    return Intl.message(
      'Change Password',
      name: 'changePassword',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Edit`
  String get edit {
    return Intl.message(
      'Edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `My pets`
  String get myPets {
    return Intl.message(
      'My pets',
      name: 'myPets',
      desc: '',
      args: [],
    );
  }

  /// `Add pet service`
  String get addPetService {
    return Intl.message(
      'Add pet service',
      name: 'addPetService',
      desc: '',
      args: [],
    );
  }

  /// `My favourites`
  String get myFavorites {
    return Intl.message(
      'My favourites',
      name: 'myFavorites',
      desc: '',
      args: [],
    );
  }

  /// `Invite friends`
  String get inviteFriends {
    return Intl.message(
      'Invite friends',
      name: 'inviteFriends',
      desc: '',
      args: [],
    );
  }

  /// `Support`
  String get help {
    return Intl.message(
      'Support',
      name: 'help',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Sign Out`
  String get signOut {
    return Intl.message(
      'Sign Out',
      name: 'signOut',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Verification`
  String get verification {
    return Intl.message(
      'Verification',
      name: 'verification',
      desc: '',
      args: [],
    );
  }

  /// `We have sent a verification code to`
  String get sentVerification {
    return Intl.message(
      'We have sent a verification code to',
      name: 'sentVerification',
      desc: '',
      args: [],
    );
  }

  /// `Received Code`
  String get receiveCode {
    return Intl.message(
      'Received Code',
      name: 'receiveCode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter code your sent`
  String get enterCode {
    return Intl.message(
      'Please enter code your sent',
      name: 'enterCode',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your new password`
  String get enterNewPassword {
    return Intl.message(
      'Please enter your new password',
      name: 'enterNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your confirm new password`
  String get enterConfirmNewPass {
    return Intl.message(
      'Please enter your confirm new password',
      name: 'enterConfirmNewPass',
      desc: '',
      args: [],
    );
  }

  /// `Confirm New Password`
  String get confirmNewPassword {
    return Intl.message(
      'Confirm New Password',
      name: 'confirmNewPassword',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get newPassword {
    return Intl.message(
      'New Password',
      name: 'newPassword',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirmPassword {
    return Intl.message(
      'Confirm Password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your confirm password`
  String get comparePassword {
    return Intl.message(
      'Please enter your confirm password',
      name: 'comparePassword',
      desc: '',
      args: [],
    );
  }

  /// `confirm password not equal password`
  String get notEqualPassword {
    return Intl.message(
      'confirm password not equal password',
      name: 'notEqualPassword',
      desc: '',
      args: [],
    );
  }

  /// `By signing up you agree to our Terms of use and Privacy Policy`
  String get terms {
    return Intl.message(
      'By signing up you agree to our Terms of use and Privacy Policy',
      name: 'terms',
      desc: '',
      args: [],
    );
  }

  /// `Sign up as a Doctor`
  String get signUpAsADoctor {
    return Intl.message(
      'Sign up as a Doctor',
      name: 'signUpAsADoctor',
      desc: '',
      args: [],
    );
  }

  /// `Already have account?`
  String get alreadyHaveAccount {
    return Intl.message(
      'Already have account?',
      name: 'alreadyHaveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get fullName {
    return Intl.message(
      'Full Name',
      name: 'fullName',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your phone`
  String get enterPhone {
    return Intl.message(
      'Please enter your phone',
      name: 'enterPhone',
      desc: '',
      args: [],
    );
  }

  /// `Don't have an account?`
  String get haveNotAccount {
    return Intl.message(
      'Don\'t have an account?',
      name: 'haveNotAccount',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get updateProfile {
    return Intl.message(
      'Update',
      name: 'updateProfile',
      desc: '',
      args: [],
    );
  }

  /// `LogOut`
  String get logout {
    return Intl.message(
      'LogOut',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Forgot password?`
  String get forgotPass {
    return Intl.message(
      'Forgot password?',
      name: 'forgotPass',
      desc: '',
      args: [],
    );
  }

  /// `enter_a_valid_email`
  String get enterAValidEm {
    return Intl.message(
      'enter_a_valid_email',
      name: 'enterAValidEm',
      desc: '',
      args: [],
    );
  }

  /// `Sign Up`
  String get signUp {
    return Intl.message(
      'Sign Up',
      name: 'signUp',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your Full Name`
  String get enterName {
    return Intl.message(
      'Please enter your Full Name',
      name: 'enterName',
      desc: '',
      args: [],
    );
  }

  /// `name more than 6 charts `
  String get enterCharNamePls {
    return Intl.message(
      'name more than 6 charts ',
      name: 'enterCharNamePls',
      desc: '',
      args: [],
    );
  }

  /// `Create Post `
  String get createPost {
    return Intl.message(
      'Create Post ',
      name: 'createPost',
      desc: '',
      args: [],
    );
  }

  /// `What\'s on your mind ?`
  String get labelPost {
    return Intl.message(
      'What\\\'s on your mind ?',
      name: 'labelPost',
      desc: '',
      args: [],
    );
  }

  /// `Add Record`
  String get addRecord {
    return Intl.message(
      'Add Record',
      name: 'addRecord',
      desc: '',
      args: [],
    );
  }

  /// `Add Pet`
  String get addPet {
    return Intl.message(
      'Add Pet',
      name: 'addPet',
      desc: '',
      args: [],
    );
  }

  /// `Pet Name`
  String get petName {
    return Intl.message(
      'Pet Name',
      name: 'petName',
      desc: '',
      args: [],
    );
  }

  /// `Name Of Record`
  String get NameOfRecord {
    return Intl.message(
      'Name Of Record',
      name: 'NameOfRecord',
      desc: '',
      args: [],
    );
  }

  /// `Data`
  String get DateOfRecord {
    return Intl.message(
      'Data',
      name: 'DateOfRecord',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get TimeOfRecord {
    return Intl.message(
      'Time',
      name: 'TimeOfRecord',
      desc: '',
      args: [],
    );
  }

  /// `Your Appointments`
  String get yourAppointments {
    return Intl.message(
      'Your Appointments',
      name: 'yourAppointments',
      desc: '',
      args: [],
    );
  }

  /// `Add Service Supplier`
  String get AddServiceSupplier {
    return Intl.message(
      'Add Service Supplier',
      name: 'AddServiceSupplier',
      desc: '',
      args: [],
    );
  }

  /// `Service Name`
  String get ServiceName {
    return Intl.message(
      'Service Name',
      name: 'ServiceName',
      desc: '',
      args: [],
    );
  }

  /// `Service Phone`
  String get ServicePhone {
    return Intl.message(
      'Service Phone',
      name: 'ServicePhone',
      desc: '',
      args: [],
    );
  }

  /// `Service location`
  String get ServiceLocation {
    return Intl.message(
      'Service location',
      name: 'ServiceLocation',
      desc: '',
      args: [],
    );
  }

  /// `Add Service Image`
  String get ServiceImage {
    return Intl.message(
      'Add Service Image',
      name: 'ServiceImage',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Please Add Service`
  String get searchValid {
    return Intl.message(
      'Please Add Service',
      name: 'searchValid',
      desc: '',
      args: [],
    );
  }

  /// `Search For Service`
  String get searchFor {
    return Intl.message(
      'Search For Service',
      name: 'searchFor',
      desc: '',
      args: [],
    );
  }

  /// `Please Verify Phone`
  String get pleaseVerifyPhone {
    return Intl.message(
      'Please Verify Phone',
      name: 'pleaseVerifyPhone',
      desc: '',
      args: [],
    );
  }

  /// `Add  Your Comment . . . .`
  String get addComment {
    return Intl.message(
      'Add  Your Comment . . . .',
      name: 'addComment',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Follow Confirmation`
  String get followConfirmation {
    return Intl.message(
      'Follow Confirmation',
      name: 'followConfirmation',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancelFollow {
    return Intl.message(
      'Cancel',
      name: 'cancelFollow',
      desc: '',
      args: [],
    );
  }

  /// `Publish`
  String get publish {
    return Intl.message(
      'Publish',
      name: 'publish',
      desc: '',
      args: [],
    );
  }

  /// `What are you thinking .... ?`
  String get enterYourText {
    return Intl.message(
      'What are you thinking .... ?',
      name: 'enterYourText',
      desc: '',
      args: [],
    );
  }

  /// `Species`
  String get species {
    return Intl.message(
      'Species',
      name: 'species',
      desc: '',
      args: [],
    );
  }

  /// `Your Supplier`
  String get yourClinic {
    return Intl.message(
      'Your Supplier',
      name: 'yourClinic',
      desc: '',
      args: [],
    );
  }

  /// `Name`
  String get name {
    return Intl.message(
      'Name',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Speciality`
  String get speciality {
    return Intl.message(
      'Speciality',
      name: 'speciality',
      desc: '',
      args: [],
    );
  }

  /// `Location`
  String get addressCity {
    return Intl.message(
      'Location',
      name: 'addressCity',
      desc: '',
      args: [],
    );
  }

  /// `Your Profile`
  String get profile {
    return Intl.message(
      'Your Profile',
      name: 'profile',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message(
      'Dark Mode',
      name: 'darkMode',
      desc: '',
      args: [],
    );
  }

  /// `language Mode`
  String get langMode {
    return Intl.message(
      'language Mode',
      name: 'langMode',
      desc: '',
      args: [],
    );
  }

  /// `Remove Clinic`
  String get removeClinic {
    return Intl.message(
      'Remove Clinic',
      name: 'removeClinic',
      desc: '',
      args: [],
    );
  }

  /// `Add available times`
  String get addAvailabilities {
    return Intl.message(
      'Add available times',
      name: 'addAvailabilities',
      desc: '',
      args: [],
    );
  }

  /// `Open At`
  String get openAt {
    return Intl.message(
      'Open At',
      name: 'openAt',
      desc: '',
      args: [],
    );
  }

  /// `Close In`
  String get closeIn {
    return Intl.message(
      'Close In',
      name: 'closeIn',
      desc: '',
      args: [],
    );
  }

  /// `Booking`
  String get booking {
    return Intl.message(
      'Booking',
      name: 'booking',
      desc: '',
      args: [],
    );
  }

  /// `Add Appointment`
  String get addAppointment {
    return Intl.message(
      'Add Appointment',
      name: 'addAppointment',
      desc: '',
      args: [],
    );
  }

  /// `Choose Pet`
  String get chosePet {
    return Intl.message(
      'Choose Pet',
      name: 'chosePet',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Update Appointment`
  String get updateAppointment {
    return Intl.message(
      'Update Appointment',
      name: 'updateAppointment',
      desc: '',
      args: [],
    );
  }

  /// `General Information`
  String get generalInformation {
    return Intl.message(
      'General Information',
      name: 'generalInformation',
      desc: '',
      args: [],
    );
  }

  /// `Doctor Name`
  String get doctorName {
    return Intl.message(
      'Doctor Name',
      name: 'doctorName',
      desc: '',
      args: [],
    );
  }

  /// `Edit Comment . . . .`
  String get editComment {
    return Intl.message(
      'Edit Comment . . . .',
      name: 'editComment',
      desc: '',
      args: [],
    );
  }

  /// `reply`
  String get reply {
    return Intl.message(
      'reply',
      name: 'reply',
      desc: '',
      args: [],
    );
  }

  /// `Comments`
  String get comments {
    return Intl.message(
      'Comments',
      name: 'comments',
      desc: '',
      args: [],
    );
  }

  /// `Delete Comment`
  String get deleteComment {
    return Intl.message(
      'Delete Comment',
      name: 'deleteComment',
      desc: '',
      args: [],
    );
  }

  /// `Comment Reply`
  String get commentReply {
    return Intl.message(
      'Comment Reply',
      name: 'commentReply',
      desc: '',
      args: [],
    );
  }

  /// `Your Upcoming Appointments`
  String get yourUpcomingAppointments {
    return Intl.message(
      'Your Upcoming Appointments',
      name: 'yourUpcomingAppointments',
      desc: '',
      args: [],
    );
  }

  /// `breed`
  String get breed {
    return Intl.message(
      'breed',
      name: 'breed',
      desc: '',
      args: [],
    );
  }

  /// `gender`
  String get gender {
    return Intl.message(
      'gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `Unique Code`
  String get uniqueCode {
    return Intl.message(
      'Unique Code',
      name: 'uniqueCode',
      desc: '',
      args: [],
    );
  }

  /// `location`
  String get location {
    return Intl.message(
      'location',
      name: 'location',
      desc: '',
      args: [],
    );
  }

  /// `city`
  String get city {
    return Intl.message(
      'city',
      name: 'city',
      desc: '',
      args: [],
    );
  }

  /// `Remove post`
  String get removePost {
    return Intl.message(
      'Remove post',
      name: 'removePost',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
