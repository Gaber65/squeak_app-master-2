import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconly/iconly.dart';
import 'package:squeak/core/main_basic/main_basic.dart';
import 'package:squeak/features/layout/presentation/controller/Home_cubit/squeak_cubit.dart';
import 'package:squeak/features/layout/presentation/screens/vaccination/pet_vaccination.dart';

import '../../../../../core/service/service_locator.dart';
import '../../../../../core/widgets/components/styles.dart';
import '../../../../../core/widgets/elevated_button.dart';
import '../../../../../core/widgets/my_form_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import '../Contact_us/contact_us_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class ContactUsScreen extends StatelessWidget {
  ContactUsScreen({Key? key}) : super(key: key);

  var phoneController = TextEditingController();

  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var addressController = TextEditingController();

  var commentController = TextEditingController();

  var titleController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<SqueakCubit>()..getProfile(),
        ),
        BlocProvider(
          create: (context) => sl<ContactUsCubit>(),
        ),
      ],
      child: BlocConsumer<ContactUsCubit, ContactUsState>(
        listener: (context, state) {},
        builder: (context, state) {
          SqueakCubit.get(context).getProfile().then(
            (value) {
              phoneController.text =
                  SqueakCubit.get(context).profile!.data!.phone ?? '';
              nameController.text =
                  SqueakCubit.get(context).profile!.data!.fullName ?? '';
              emailController.text =
                  SqueakCubit.get(context).profile!.data!.email ?? '';
              phoneController.text =
                  SqueakCubit.get(context).profile!.data!.phone ?? '';
            },
          );

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                S.of(context).help,
              ),
            ),
            body: _buildBody(context, state),
          );
        },
      ),
    );
  }

  Widget _buildBody(context, ContactUsState state) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  _buildProfile(context),
                  const SizedBox(height: 80),
                  _buildProfileDtl(context)
                ],
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: _buildLoginDetail(context, state),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String image =
      'https://img.freepik.com/free-vector/contact-us-concept-landing-page_52683-12191.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais';

  Widget _buildProfile(context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.35,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(image),
        ),
      ),
    );
  }

  Widget _buildLoginDetail(context, ContactUsState state) {
    return Center(
      child: Form(
        key: formKey,
        child: Container(
          padding: const EdgeInsets.all(24),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 70),
          decoration: BoxDecoration(
            color: BreedsTypeCubit.get(context).isDark
                ? Colors.grey.shade900
                : Colors.white60,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8.0,
              ),
            ],
          ),
          child: Column(
            children: [
              MyFormField(
                controller: nameController,
                type: TextInputType.emailAddress,
                label: isArabic() ? 'اسمك' : 'Your Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please add Your Name';
                  }
                  return null;
                },
                isUpperCase: false,
                suffix: const Icon(
                  IconlyLight.profile,
                ),
                fillColor: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              MyFormField(
                controller: phoneController,
                type: TextInputType.phone,
                label: isArabic() ? "رقم الموبيل" : 'Your Phone',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please add Your Phone';
                  }
                  return null;
                },
                isUpperCase: false,
                suffix: const Icon(IconlyLight.call),
                fillColor: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              MyFormField(
                controller: emailController,
                type: TextInputType.emailAddress,
                label: isArabic() ? 'بريدك الالكتروني' : 'Your Email',
                validator: (value) {
                  // Regex pattern to validate email address
                  String pattern =
                      r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*\.)+[a-zA-Z]{2,7}$';
                  RegExp regex = RegExp(pattern);
                  if (!regex.hasMatch(value!)) {
                    return 'Enter a valid email address';
                  } else {
                    return null;
                  }
                },
                isUpperCase: false,
                suffix: const Icon(IconlyLight.message),
                fillColor: Colors.white,
              ),
              SizedBox(
                height: 10,
              ),
              MyFormField(
                controller: titleController,
                type: TextInputType.text,
                label: isArabic() ? 'عنوان' : 'Title',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please add Your title';
                  }
                  return null;
                },
                isUpperCase: false,
                suffix: const Icon(IconlyLight.ticket),
                fillColor: Colors.white,
              ),
              textField(
                S.of(context).addComment,
                IconlyLight.chat,
                commentController,
                'Please add Comment',
                maxLines: 3,
              ),
              const SizedBox(height: 30),
              ConditionalBuilder(
                condition: state is! ContactUsSendLoading,
                builder: (context) {
                  return MyElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ContactUsCubit.get(context).addTicket(
                          title: titleController.text,
                          phone: phoneController.text,
                          comment: commentController.text,
                          email: emailController.text,
                          statues: false,
                          fullName: nameController.text,
                        );
                      }
                    },
                    colors: Colors.red,
                    text: S.of(context).send,
                  );
                },
                fallback: (context) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileDtl(context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height * 0.45,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [],
      ),
    );
  }
}
