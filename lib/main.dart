// Don't forget to make the changes mentioned in
// https://github.com/bitsdojo/bitsdojo_window#getting-started

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  appWindow.size = const Size(600, 450);
  appWindow.show();
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(600, 450);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.show();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Column(
          children: [
            CustomTitleBar(),
            Center(child: Text("data")),
          ],
        ),
      ),
    );
  }
}

class CustomTitleBar extends StatelessWidget {
  const CustomTitleBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DragToMoveArea(
      child: Container(
        color: Colors.black,
        width: double.maxFinite,
        height: 30,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppTitleBarButton(
                  onPressed: () {},
                  color: Colors.blueGrey.shade700,
                  icon: Icons.settings,
                ),
              ),
            ),
            const Expanded(
              child: Center(
                child: Text(
                  "Cheque Printing",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppTitleBarButton(
                    onPressed: () => appWindow.minimize(),
                    color: Colors.yellow.shade700,
                    icon: Icons.close_fullscreen_rounded,
                  ),
                  AppTitleBarButton(
                    onPressed: () => appWindow.maximizeOrRestore(),
                    color: Colors.green,
                    icon: Icons.fullscreen,
                  ),
                  AppTitleBarButton(
                    onPressed: () => appWindow.close(),
                    color: Colors.red,
                    icon: Icons.close,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AppTitleBarButton extends StatelessWidget {
  const AppTitleBarButton(
      {super.key,
      required this.color,
      required this.icon,
      required this.onPressed,
      this.width,
      this.child});
  final Color color;
  final IconData icon;
  final VoidCallback onPressed;
  final double? width;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: child != null ? null : 25,
      child: CupertinoButton(
        onPressed: onPressed,
        padding: EdgeInsets.zero,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: ColoredBox(
            color: color,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: child ?? Icon(icon, size: 12, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
