import 'package:flutter/material.dart';

class CopyRight extends StatelessWidget {
  const CopyRight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      padding: const EdgeInsets.only(top: 8),
      decoration: const BoxDecoration(
          color: Colors.black,
          border: Border(top: BorderSide(width: 2, color: Colors.white))),
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
              child: Center(
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                  style: TextStyle(fontSize: 14, color: Colors.white),
                  children: [
                    TextSpan(text: 'Copyrights © All Rights Reserved By '),
                    TextSpan(
                        text: 'PT Sinergi Kukerja Indonesia',
                        style: TextStyle(color: Colors.amber))
                  ]),
            ),
          )),
        ],
      ),
    );
  }
}
