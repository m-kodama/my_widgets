import 'package:flutter/material.dart';
import 'package:my_widgets/widgets/blur_card.dart';

class BlurCardChild extends StatelessWidget {
  const BlurCardChild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            'サンプル',
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('サンプルボタン'),
        ),
      ],
    );
  }
}

Widget blurCard() => Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Image.asset('assets/images/bg.jpg'),
        ),
        const Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: BlurCard(
              padding: EdgeInsets.all(16),
              child: BlurCardChild(),
            ),
          ),
        ),
      ],
    );
