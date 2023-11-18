import 'package:flutter/material.dart';
import 'package:furious_red_dragon/constants.dart';

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
    return Container(
      decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          shadows: const [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 4),
              spreadRadius: 0,
            )
          ]),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: kFuriousRedColor,
          maximumSize: const Size(300, 100),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        onPressed: () => onTap(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            buttonTitle,
            style: kGlobalTextStyle.copyWith(color: Colors.white, fontSize: 18),
          ),
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
    return Container(
        decoration: ShapeDecoration(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            shadows: const [
              BoxShadow(
                color: Color(0x3F000000),
                blurRadius: 4,
                offset: Offset(0, 4),
                spreadRadius: 0,
              )
            ]),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            maximumSize: const Size(300, 100),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                side: BorderSide(color: borderColor)),
          ),
          onPressed: () => onTap(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(buttonTitle,
                style: kGlobalTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )),
          ),
        ));
  }
}

class SmallButton extends StatelessWidget {
  const SmallButton(
      {super.key,
      this.backgroundColor = kDarkerGrey,
      required this.onTap,
      required this.buttonTitle});

  final Function onTap;
  final String buttonTitle;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          backgroundColor: backgroundColor,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(5)),
          )),
      onPressed: () => onTap(),
      child: Text(
        buttonTitle,
        textAlign: TextAlign.center,
        style: kGlobalTextStyle.copyWith(
          color: Colors.black,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
