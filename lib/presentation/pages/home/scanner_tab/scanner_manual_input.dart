part of 'scanner_page.dart';

class ScannerManualInput extends StatefulWidget {
  const ScannerManualInput({Key? key}) : super(key: key);

  @override
  State<ScannerManualInput> createState() => _ScannerManualInput();
}

class _ScannerManualInput extends State<ScannerManualInput> {
  bool showInfoPopUp = false;
  TextEditingController barCodeController = TextEditingController();
  Color buttonColor = kDarkerGrey;
  Color buttonTextColor = Colors.black;
  int inputMaxLenght = 8;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ScannerBloc, ScannerState>(
      listener: (BuildContext context, ScannerState state) {
        if (state.isItemFound()) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => ItemDetailsPage()));
        }
      },
      child: WillPopScope(
        onWillPop: () async {
          context.read<ScannerBloc>().add(ScannerInitialized());
          Navigator.pop(context);
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: const BackButton(
              color: Colors.white,
            ),
            toolbarHeight: 80,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            backgroundColor: kFuriousRedColor,
            title: const Text('Skanowanie'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Wprowadź kod kreskowy:',
                  style: kGlobalTextStyle.copyWith(fontSize: 22),
                ),
                kBigGap,
                inputAndIcon(),
                kBigGap,
                SmallButton(
                  onTap: () {
                    context.read<ScannerBloc>().add(
                        ScannerManualInputValue(code: barCodeController.text));
                  },
                  buttonTitle: ('Zatwierdź'),
                  backgroundColor: buttonColor,
                  textColor: buttonTextColor,
                ),
                kBigGap,
                if (showInfoPopUp) popUpInfo(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row inputAndIcon() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: barCodeController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              LengthLimitingTextInputFormatter(inputMaxLenght),
            ],
            decoration: const InputDecoration(
              counterText: '',
              hintText: 'Wprowadź cyfry',
              border: OutlineInputBorder(),
            ),
            onChanged: (text) {
              setState(() {
                colorController();
              });
            },
          ),
        ),
        kBigGap,
        IconButton(
          onPressed: () {
            setState(() {
              showInfoPopUp = !showInfoPopUp;
            });
          },
          icon: const Icon(Icons.info, size: 32),
        ),
      ],
    );
  }

  void colorController() {
    if (barCodeController.text.length != inputMaxLenght) {
      buttonColor = kDarkerGrey;
      buttonTextColor = Colors.black;
    } else {
      buttonColor = kFuriousRedColor;
      buttonTextColor = Colors.white;
    }
  }

  InfoPopUp popUpInfo() {
    return InfoPopUp(onClose: () {
      setState(() {
        showInfoPopUp = false;
      });
    });
  }
}

class InfoPopUp extends StatefulWidget {
  final VoidCallback onClose;

  const InfoPopUp({Key? key, required this.onClose}) : super(key: key);

  @override
  _InfoPopUpState createState() => _InfoPopUpState();
}

class _InfoPopUpState extends State<InfoPopUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: kFuriousRedColor,
          width: 2,
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          textAndExit(),
          textInFrame(),
        ],
      ),
    );
  }

  Row textAndExit() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Dlaczego nie mogę zatwierdzić kodu?',
          style: kGlobalTextStyle.copyWith(fontSize: 15),
        ),
        IconButton(
          onPressed: widget.onClose,
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }

  Container textInFrame() {
    return Container(
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
          width: 2,
        ),
        color: Colors.white,
      ),
      padding: const EdgeInsets.all(8),
      child: Text(
        'Przed zatwierdzeniem kodu upewnij się, że:\n'
        '  • kod składa się tylko z cyfr (bez spacji)\n'
        '  • kod składa się dokładnie z 13 cyfr\n',
        style: kGlobalTextStyle.copyWith(fontSize: 14, height: 1.5),
      ),
    );
  }
}
