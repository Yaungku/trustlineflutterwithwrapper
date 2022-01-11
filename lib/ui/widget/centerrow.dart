import 'package:flutter/material.dart';

class CenterRow extends StatelessWidget {
  final String title;
  final String sub;
  const CenterRow(this.title, this.sub, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 1,
            child: SizedBox(
              width: 500,
              child: Text(
                title,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: SizedBox(
              width: 500,
              child: SelectableText(
                sub,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
