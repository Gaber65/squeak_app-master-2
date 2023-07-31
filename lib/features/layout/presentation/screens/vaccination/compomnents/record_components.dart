import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:squeak/core/widgets/elevated_button.dart';

import '../../features/layout/presentation/controller/cubit/squeak_cubit.dart';
import '../../features/layout/presentation/screens/vaccination/vac_cubit/vaccination_cubit.dart';
import '../../features/setting/update_profile/presentation/controlls/cubit/beets_type_find_cubit.dart';
import '../resources/color_manager.dart';
import '../resources/strings_manager.dart';
import 'components/styles.dart';

Widget buildTaskItem(
  Map model,
  context,
  petId,
  TextEditingController commentController,
) =>
    Dismissible(
      key: Key(model['id'].toString()),
      background: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(
          color: appColorBtn,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const <Widget>[
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
        VaccinationCubit.get(context).deleteDate(id: model['id'], petId: petId);
      },
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Card(
          elevation: 3,
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(),
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
                                    Text(
                                      '${model['comments']}',
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: 'bold', fontSize: 15),
                                    ),
                                    const Spacer(),
                                    CircleAvatar(
                                      backgroundColor:
                                          VaccinationCubit.get(context).stateVac
                                              ? Colors.green
                                              : appColorBtn,
                                      child: IconButton(
                                        onPressed: () {
                                          VaccinationCubit.get(context)
                                              .changeEdit();
                                        },
                                        icon: Icon(
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
                  if (VaccinationCubit.get(context).edit == true)
                    Column(
                      children: [
                        SizedBox(
                          height: 18,
                        ),
                        textField(
                          'Comment',
                          Icons.feedback,
                          commentController,
                          'Please add Comment',
                          maxLines: 1,
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text('Service State'),
                            Spacer(),
                            Switch(
                              value: VaccinationCubit.get(context).stateVac,
                              onChanged: (value) {
                                VaccinationCubit.get(context).changeState();
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 12,
                        ),
                        MyElevatedButton(
                          onPressed: () {
                            VaccinationCubit.get(context).updateDate(
                                comments: commentController.text,
                                petId: petId,
                                id: model['id']);
                          },
                          colors: Colors.red,
                          text: 'Add Record',
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
Widget buildConditional(
        {required List<Map> task,
        required String petId,
        required TextEditingController commentController}) =>
    ConditionalBuilder(
      condition: task.length > 0,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) =>
              buildTaskItem(task[index], context, petId, commentController),
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
      fallback: (context) => const Center(
        child: Image(
          image: CachedNetworkImageProvider(
            'https://img.freepik.com/premium-photo/fun-illustration-cat-with-mask_183364-54530.jpg?size=626&ext=jpg&uid=R78903714&ga=GA1.1.798062041.1678310296&semt=ais',
          ),
        ),
      ),
    );
