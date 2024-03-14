import 'package:flutter/material.dart';
import 'package:smart_home/core/core.dart';
import 'package:ui_common/ui_common.dart';

import '../widgets/lighted_background.dart';
import '../widgets/page_indicators.dart';
import '../widgets/sm_home_bottom_navigation.dart';
import '../widgets/smart_room_page_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = PageController(viewportFraction: 0.8);
  final ValueNotifier<double> pageNotifier = ValueNotifier(0);
  final ValueNotifier<int> roomSelectorNotifier = ValueNotifier(-1);
  late bool _splitScreenMode; // Declare with `late` keyword

  @override
  void initState() {
    controller.addListener(pageListener);
    super.initState();
    _splitScreenMode = false;
  }

  @override
  void dispose() {
    controller
      ..removeListener(pageListener)
      ..dispose();
    super.dispose();
  }

  void pageListener() => pageNotifier.value = controller.page ?? 0;

  @override
  Widget build(BuildContext context) => LightedBackgound(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const ShAppBar(),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Text("SELECT A ROOM", style: context.bodyLarge),
                  height32,
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      clipBehavior: Clip.none,
                      children: [
                        SmartRoomsPageView(
                          pageNotifier: pageNotifier,
                          roomSelectorNotifier: roomSelectorNotifier,
                          controller: controller,
                        ),
                        Positioned.fill(
                          top: null,
                          child: Column(
                            children: [
                              PageIndicators(
                                roomSelectorNotifier: roomSelectorNotifier,
                                pageNotifier: pageNotifier,
                              ),
                              SmHomeBottomNavigationBar(
                                roomSelectorNotifier: roomSelectorNotifier,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
