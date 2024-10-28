import 'package:shadcn_flutter/shadcn_flutter.dart';

List<OverlayPosition> positions = [
  OverlayPosition.left,
  OverlayPosition.left,
  OverlayPosition.bottom,
  OverlayPosition.bottom,
  OverlayPosition.top,
  OverlayPosition.top,
  OverlayPosition.right,
  OverlayPosition.right,
];
void open(BuildContext context, int count) {
  openDrawer(
    context: context,
    expands: true,
    builder: (context) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
                'Drawer ${count + 1} at ${positions[count % positions.length].name}'),
            const Gap(16),
          ],
        ),
      );
    },
    position: positions[3],
  );
}

class Drawer extends StatefulWidget {
  const Drawer({super.key});

  @override
  State<Drawer> createState() => _DrawerState();
}

class _DrawerState extends State<Drawer> {
  @override
  Widget build(BuildContext context) {
    return PrimaryButton(
      onPressed: () {
        open(context, 0);
      },
      child: const Text('Open Drawer'),
    );
  }
}
