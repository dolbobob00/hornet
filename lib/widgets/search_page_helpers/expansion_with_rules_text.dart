import 'package:flutter/material.dart';

class ExpansionWithRules extends StatelessWidget {
  const ExpansionWithRules({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: RichText(
        text: TextSpan(
          style: Theme.of(context).textTheme.bodyMedium,
          children: [
            TextSpan(
              text: '- Dont forget to check page, on button in right corner\n',
            ),
            TextSpan(
              text: '- It\'s better to start with small letter\n',
            ),
            TextSpan(
              text: '- Use underscope "_" and not use space " "\n',
            ),
            TextSpan(
              text: '- Sometimes you must use name and surname of character\n',
            ),
            TextSpan(
              text: 'Something like: "zoro_roronoa" or "dayneris_targaryen"\n',
            ),
            TextSpan(
              text:
                  '- Sometimes you must specify name of which anime talking\n',
            ),
            TextSpan(
              text: 'Something like: "rem_(re:zero)" and "ram_(re:zero)"\n',
            ),
          ],
        ),
      ),
    );
  }
}
