import 'package:docs/ui/shadcn/shadcn_ui.dart';

// Demonstrates a vertical NavigationSidebar with labels, dividers, and gaps.
// Selection is index-based and controlled by local state.

class NavigationSidebarExample1 extends StatefulWidget {
  const NavigationSidebarExample1({super.key});

  @override
  State<NavigationSidebarExample1> createState() =>
      _NavigationSidebarExample1State();
}

class _NavigationSidebarExample1State extends State<NavigationSidebarExample1> {
  // Currently selected item index in the sidebar.
  int selected = 0;

  NavigationBarItem buildButton(String label, IconData icon) {
    // Helper for a standard navigation item with text label and icon.
    return NavigationItem(
      label: Text(label),
      child: Icon(icon),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: OutlinedContainer(
        child: NavigationSidebar(
          // Wire selection to local state.
          index: selected,
          onSelected: (index) {
            setState(() {
              selected = index;
            });
          },
          children: [
            // A mix of labels, gaps, dividers, and items can be used to
            // structure the navigation list into logical sections.
            const NavigationLabel(child: Text('Discovery')),
            buildButton('Listen Now', LucideIcons.circlePlay),
            buildButton('Browse', LucideIcons.grid2x2),
            buildButton('Radio', LucideIcons.radio),
            const NavigationGap(24),
            const NavigationDivider(),
            const NavigationLabel(child: Text('Library')),
            buildButton('Playlist', LucideIcons.listMusic),
            buildButton('Songs', LucideIcons.music),
            buildButton('For You', LucideIcons.user),
            buildButton('Artists', LucideIcons.mic),
            buildButton('Albums', LucideIcons.disc2),
            const NavigationGap(24),
            const NavigationDivider(),
            const NavigationLabel(child: Text('Playlists')),
            buildButton('Recently Added', LucideIcons.listMusic),
            buildButton('Recently Played', LucideIcons.listMusic),
            buildButton('Top Songs', LucideIcons.listMusic),
            buildButton('Top Albums', LucideIcons.listMusic),
            buildButton('Top Artists', LucideIcons.listMusic),
            buildButton('Logic Discography With Some Spice',
                LucideIcons.listMusic),
            buildButton('Bedtime Beats', LucideIcons.listMusic),
            buildButton('Feeling Happy', LucideIcons.listMusic),
            buildButton('I miss Y2K Pop', LucideIcons.listMusic),
            buildButton('Runtober', LucideIcons.listMusic),
          ],
        ),
      ),
    );
  }
}
