import 'package:flutter/material.dart';
import 'package:furious_red_dragon/main.dart';
import 'package:furious_red_dragon/pages/splash_page.dart';
import '../../constants.dart';
import 'package:furious_red_dragon/components/buttons.dart';

class DeleteAccountPage extends StatelessWidget {
  const DeleteAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.white,
        ),
        toolbarHeight: 80,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(10),
        )),
        backgroundColor: kFuriousRedColor,
        title: const Text('Usuń konto'),
        actions: const <Widget>[],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Czy na pewno chcesz usunąć konto?',
              style: kGlobalTextStyle.copyWith(fontSize: 24),
            ),
            kBigGap,
            Text(
              'Uwaga! Ta czynność jest nieodwracalna!',
              style: kGlobalTextStyle.copyWith(
                  fontSize: 18, color: kFuriousRedColor),
            ),
            kBigGap,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmallButton(
                  onTap: () {
                    Navigator.pop(context); // Close the current page
                  },
                  buttonTitle: 'Nie',
                ),
                kSmallGap,
                SmallButton(
                  onTap: () {
                    deleteUser(context);
                  },
                  buttonTitle: ('Tak'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getBackToSplash(context) {
    Navigator.pushNamed(context, SplashPage.routeName);
  }

  Future<void> deleteUser(context) async {
    var uuid = supabase.auth.currentUser?.id;

    // await supabase.auth.admin
    //     .deleteUser(uuid!)
    //     .then((value) => getBackToSplash(context));
  }
}
