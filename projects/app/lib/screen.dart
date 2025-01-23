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
  StreamSubscription? _addRouteSubscription;
  StreamSubscription? _settingRouteSubscription;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _subscribeEvents();
    });
    super.initState();
  }

  @override
  void dispose() {
    _unSubscribeEvents();
    super.dispose();
  }

  void _subscribeEvents() {
    _addRouteSubscription = _eventBus.on<AddRouteEvent>().listen((event) {
      Modular.to.pushNamed(event.route);
    });

    _settingRouteSubscription = _eventBus.on<SettingRouteEvent>().listen((event) {
      Modular.to.pushNamed(event.route);
    });
  }

  void _unSubscribeEvents() {
    _addRouteSubscription?.cancel();
    _addRouteSubscription = null;

    _settingRouteSubscription?.cancel();
    _settingRouteSubscription = null;
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
