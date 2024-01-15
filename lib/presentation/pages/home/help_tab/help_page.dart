import 'package:flutter/material.dart';
import 'package:furious_red_dragon/core/constants.dart';

class FAQEntry extends StatefulWidget {
  final String question;
  final String answer;

  const FAQEntry({
    Key? key,
    required this.question,
    required this.answer,
  }) : super(key: key);

  @override
  _FAQEntryState createState() => _FAQEntryState();
}

class _FAQEntryState extends State<FAQEntry> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isExpanded ? null : 55, // null height when expanded

      child: Container(
        width: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5),
        ),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  widget.question,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold),
                ),
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
              ),
              if (isExpanded)
                Container(
                  width: 500,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Text(
                    widget.answer,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class FAQSection extends StatelessWidget {
  const FAQSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      width: 333,
      height: 600,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListView(
        children: const [
          kSmallGap,
          FAQEntry(
            question: 'Do czego służy Wściekły Czerwony Smok?',
            answer: '<<<Insert text z dokumentacji >>>',
          ),
          kSmallGap,
          FAQEntry(
            question: 'Czy istnieje wizualny podgląd do budynków i sal?',
            answer:
                'Aby uzyskać wizualny podgląd do planów budynków i rozmieszczeń sal: \nOtwórz aplikację Kampus \nPobierz aplikację Kampus',
          ),
          kSmallGap,
          FAQEntry(
            question: 'Kto może dodawać nowych użytkowników?',
            answer:
                'Tylko osoba z uprawnieniami administratora może dodawać nowych użytkowników.',
          ),
          kSmallGap,
          FAQEntry(
            question: 'Pytanie czwarte',
            answer: 'Odpowiedź na pytanie czwarte.',
          ),
        ],
      ),
    );
  }
}

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: kPageBackgroundColor,
      child: ListView(
        children: const [
          FAQSection(),
        ],
      ),
    );
  }
}
