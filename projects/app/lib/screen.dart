import 'dart:async';

import 'package:add/add.dart';
import 'package:event_bus/event_bus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:setting/setting.dart';

class AppScreen extends StatefulWidget {
  const AppScreen({super.key});

  @override
  State<AppScreen> createState() => _AppScreenState();
}

class _AppScreenState extends State<AppScreen> {
  int _currentIndex = 0;
  final EventBus _eventBus = Modular.get<EventBus>();
  late final StreamSubscription _addRouteSubscription;
  late final StreamSubscription _settingRouteSubscription;

  @override
  void initState() {
    _addRouteSubscription = _eventBus.on<AddRouteEvent>().listen((event) {
      Modular.to.pushNamed(event.route);
    });

    _settingRouteSubscription = _eventBus.on<SettingRouteEvent>().listen((event) {
      Modular.to.pushNamed(event.route);
    });
    super.initState();
  }

  @override
  void dispose() {
    _addRouteSubscription.cancel();
    _settingRouteSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [
          AddScreen(),
          SettingScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: '추가',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '설정',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
