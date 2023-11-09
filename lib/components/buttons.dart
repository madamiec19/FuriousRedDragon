import 'package:flutter/material.dart';
import 'package:furious_red_dragon/styles.dart';

class BigRedButton extends StatelessWidget {
  const BigRedButton({
    super.key,
    required this.onTap,
    required this.buttonTitle,
  });

  final Function onTap;
  final String buttonTitle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: kFuriousRedColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        shadowColor: Colors.black,
        elevation: kButtonElevation,
      ),
      onPressed: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Text(
          buttonTitle,
          style: const TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
    );
  }
}

class BigWhiteButton extends StatelessWidget {
  const BigWhiteButton(
      {super.key,
      required this.onTap,
      required this.buttonTitle,
      this.borderColor = Colors.black});
  final Function onTap;
  final String buttonTitle;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
            side: BorderSide(color: borderColor)),
        shadowColor: Colors.black,
        elevation: kButtonElevation,
      ),
      onPressed: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Text(
          buttonTitle,
          style: const TextStyle(color: Colors.black, fontSize: 18.0),
        ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  const SmallButton(
      {super.key,
      this.backgroundColor = kLightGrey,
      required this.onTap,
      required this.buttonTitle});

  final Function onTap;
  final String buttonTitle;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4.0),
          minimumSize: const Size(50.0, 0),
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
          )),
      onPressed: () => onTap(),
      child: Text(
        buttonTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
    );
  }
}
