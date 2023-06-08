import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:squeak/features/layout/cubit/squeak_cubit.dart';

Widget buildTaskItem(
  Map model,
  context,
) =>
    Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Row(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.black12,
              foregroundColor: Colors.black,
              child: Text('${model['time']}'),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Pit Name : ${model['pitName']}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    'Data Vaccination : ${model['data']}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  Text(
                    'Type Vaccination : ${model['typeVaccination']}',
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        SqueakCubit.get(context).deleteDate(id: model['id']);
      },
    );
Widget buildConditional({
  required List<Map> task,
}) =>
    ConditionalBuilder(
      condition: task.length > 0,
      builder: (context) => ListView.separated(
          itemBuilder: (context, index) => buildTaskItem(task[index], context),
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

void NavigatorGoTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );
