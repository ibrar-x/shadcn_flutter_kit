import 'package:flutter/material.dart';
import '../tabs/tabs.dart';
import 'tabs.dart';
import '../preview_types.dart';

class TabsPreview extends StatefulWidget {
  const TabsPreview({super.key});

  @override
  State<TabsPreview> createState() => _TabsPreviewState();
}

class _TabsPreviewState extends State<TabsPreview> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Tabs(
                  index: index,
                  children: const [
                    TabItem(child: Text('Tab 1')),
                    TabItem(child: Text('Tab 2')),
                    TabItem(child: Text('Tab 3')),
                  ],
                  onChanged: (int value) {
                    setState(() {
                      index = value;
                    });
                  },
                ),
                const SizedBox(height: 8),
                IndexedStack(
                  index: index,
                  children: [
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tab 1 Content',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text('This is the content for tab 1'),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tab 2 Content',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text('This is the content for tab 2'),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Tab 3 Content',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text('This is the content for tab 3'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
