import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:furious_red_dragon/data/bloc/history_database/history_database_bloc.dart';

class AddUserPage extends StatelessWidget {
  const AddUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .read<HistoryDatabaseBloc>()
            .add(HistoryAdminUsersButtonClicked());
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            TextField(),
            TextField(),
            TextButton(
                onPressed: () {
                  context.read<HistoryDatabaseBloc>().add(
                        HistoryAdminAddUser(
                          email: 'pracownik@test.com',
                          name: 'pracownik',
                        ),
                      );
                },
                child: Text('DODAJ PAZIA'))
          ],
        ),
      ),
    );
  }
}
