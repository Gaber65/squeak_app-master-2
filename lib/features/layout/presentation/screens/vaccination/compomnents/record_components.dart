import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:squeak/core/widgets/elevated_button.dart';

import '../../../../../../core/service/service_locator.dart';
import '../vac_cubit/vaccination_cubit.dart';
import '../../../../../setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import '../../../../../../core/resources/color_manager.dart';
import '../../../../../../core/resources/strings_manager.dart';
import '../../../../../../core/widgets/components/styles.dart';

Widget buildTaskItem(
  Map model,
  context,
  petId,
  TextEditingController commentController,
  int index,
  BuildContext contextBloc,
) =>
    Dismissible(
      key: Key(VaccinationCubit.get(context).ids[index]),
      background: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          color: appColorBtn,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Icon(
                  Icons.delete,
                  color: Colors.white,
                ),
                Text(
                  " Delete",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ),
        ),
      ),
      onDismissed: (direction) {
        VaccinationCubit.get(context).deleteDate(
          id: VaccinationCubit.get(context).ids[index],
          petId: petId,
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Card(
          elevation: 3,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: const BoxDecoration(),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${model['pitName']}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: 'bold', fontSize: 15),
                                    ),
                                    Text(
                                      '⏱ ${model['data']}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontSize: 14, fontFamily: 'bold'),
                                    ),
                                    Text(
                                      '${model['typeVaccination']}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          fontFamily: 'bold', fontSize: 15),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    SizedBox(

                                      width: MediaQuery.of(context).size.width/1.5,

                                      child: Text(
                                        '${model['comments']}',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,

                                        style: const TextStyle(
                                            fontFamily: 'bold', fontSize: 15),
                                      ),
                                    ),
                                    const Spacer(),
                                    CircleAvatar(
                                      backgroundColor: model['statues'] == true
                                          ? Colors.green
                                          : appColorBtn,
                                      child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    "Edit Your Pet Service",),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    const SizedBox(
                                                      height: 18,
                                                    ),
                                                    textField(
                                                      'Comment',
                                                      Icons.feedback,
                                                      commentController,
                                                      'Please add Comment',
                                                      maxLines: 1,
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            'Service State'),
                                                        const Spacer(),
                                                        Switch(
                                                          value: VaccinationCubit
                                                                  .get(
                                                                      contextBloc)
                                                              .edit,
                                                          onChanged: (value) {
                                                            VaccinationCubit.get(
                                                                    contextBloc)
                                                                .changeEdit(
                                                              comments: model[
                                                                  'comments'],
                                                              petId: petId,
                                                              id: VaccinationCubit
                                                                      .get(
                                                                          contextBloc)
                                                                  .ids[index],
                                                              gender:
                                                                  '${model['gender']}',
                                                              data:
                                                                  model['data'],
                                                              pitName: model[
                                                                  'pitName'],
                                                              typeId: model[
                                                                  'typeId'],
                                                              typeVaccination:
                                                                  model[
                                                                      'typeVaccination'],
                                                            );
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 12,
                                                    ),
                                                    MyElevatedButton(
                                                      onPressed: () {
                                                        VaccinationCubit.get(
                                                                contextBloc)
                                                            .updateDate(
                                                          comments:
                                                              commentController
                                                                  .text,
                                                          petId: petId,
                                                          id: VaccinationCubit
                                                                  .get(
                                                                      contextBloc)
                                                              .ids[index],
                                                          gender:
                                                              '${model['gender']}',
                                                          data: model['data'],
                                                          pitName:
                                                              model['pitName'],
                                                          statues:
                                                              model['statues'],
                                                          typeId:
                                                              model['typeId'],
                                                          typeVaccination: model[
                                                              'typeVaccination'],
                                                        ).then((value) {
                                                          Navigator.pop(context);
                                                        });
                                                      },
                                                      colors: Colors.red,
                                                      text: 'Save',
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
Widget buildConditional({
  required List<Map> task,
  required String petId,
  required TextEditingController commentController,
  required BuildContext contextBloc,
}) =>
    ConditionalBuilder(
        condition: task.length > 0,
        builder: (context) => ListView.separated(
            itemBuilder: (context, index) => buildTaskItem(task[index], context,
                petId, commentController, index, contextBloc),
            separatorBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: 1.0,
                    color: Colors.black38,
                  ),
                ),
            itemCount: task.length),
        fallback: (context) {
          if (task.isEmpty) {
            return const Center(
              child: Image(
                image: CachedNetworkImageProvider(
                  'https://img.freepik.com/premium-photo/fun-illustration-cat-with-mask_183364-54530.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais',
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
