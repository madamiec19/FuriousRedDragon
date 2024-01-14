import 'package:flutter/material.dart';
import 'package:furious_red_dragon/core/constants.dart';
import 'package:furious_red_dragon/presentation/components/buttons.dart';

class UsersStream extends StatefulWidget {
  const UsersStream({super.key});

  @override
  State<UsersStream> createState() => _UsersStreamState();
}

class _UsersStreamState extends State<UsersStream> {
  final _stream = client.from('roles').stream(primaryKey: ['id']);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _stream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                color: kFuriousRedColor,
                backgroundColor: kLightGrey,
              ),
            );
          }
          final users = snapshot.data;
          List<BasicListItem> itemsListItems = [];
          for (var user in users!) {
            final name = user['name'];
            final status = user['status'];
            final email = user['email'];
            final userString = name + ' ' + status + ' ' + email;
            itemsListItems.add(BasicListItem(
              onTap: () {},
              buttonTitle: userString,
            ));
          }
          return Expanded(
            child: ListView(
              children: itemsListItems,
            ),
          );
        });
  }
}
