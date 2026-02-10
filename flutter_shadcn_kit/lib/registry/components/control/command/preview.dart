import 'package:flutter/material.dart';
import '../command/command.dart';

class CommandPreview extends StatelessWidget {
  const CommandPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 300,
        height: 300,
        child: Command(
          builder: (context, query) async* {
            final items = <String, List<String>>{
              'Suggestions': ['Calendar', 'Search Emoji', 'Launch'],
              'Settings': ['Profile', 'Mail', 'Settings'],
            };
            final icons = <String, Widget>{
              'Calendar': const Icon(Icons.calendar_today),
              'Search Emoji': const Icon(Icons.emoji_emotions_outlined),
              'Launch': const Icon(Icons.rocket_launch_outlined),
              'Profile': const Icon(Icons.person_outline),
              'Mail': const Icon(Icons.mail_outline),
              'Settings': const Icon(Icons.settings_outlined),
            };
            for (final values in items.entries) {
              final resultItems = <Widget>[];
              for (final item in values.value) {
                if (query == null ||
                    item.toLowerCase().contains(query.toLowerCase())) {
                  resultItems.add(
                    CommandItem(
                      title: Text(item),
                      leading: icons[item],
                      onTap: () {},
                    ),
                  );
                }
              }
              if (resultItems.isNotEmpty) {
                yield [
                  CommandCategory(
                    title: Text(values.key),
                    children: resultItems,
                  ),
                ];
              }
            }
          },
        ),
      ),
    );
  }
}
