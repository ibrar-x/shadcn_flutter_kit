import 'package:flutter/material.dart';
import '../accordion/accordion.dart';
import 'accordion.dart';

class AccordionPreview extends StatelessWidget {
  const AccordionPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: 600,
              child: const Accordion(
                items: [
                  AccordionItem(
                    trigger: AccordionTrigger(
                      child: Text('Is it accessible?'),
                    ),
                    content: Text(
                      'Yes. It adheres to the WAI-ARIA design pattern.',
                    ),
                  ),
                  AccordionItem(
                    trigger: AccordionTrigger(
                      child: Text('Is it styled?'),
                    ),
                    content: Text(
                      'Yes. It comes with default styles that you can customize.',
                    ),
                  ),
                  AccordionItem(
                    trigger: AccordionTrigger(
                      child: Text('Is it animated?'),
                    ),
                    content: Text(
                      'Yes. It is animated by default. You can disable it if you prefer.',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
