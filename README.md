# Flutter Event Bus

``` cmd
environment:
sdk: 3.6.0
flutter: 3.27.1

dependencies:
flutter_modular: 6.3.4
event_bus: 2.0.1
```

## Event Bus란?

Flutter 에서 이벤트 버스는 컴포넌트 간의 통신을 위해 사용되는 디자인 패턴. 앱 내에서 이벤트를 발생시키고, 이를 다른 부분에서 수신하여 반응하는 형식이다.


## 핵심 개념

**이벤트(Event)**
어떤 사건이 발생했음을 알리는 신호나 데이터

**퍼블리셔(Publisher)**
이벤트를 생성하고 발송하는 주체

**서브스크라이버(Subscriber)**
이벤트를 수신하여 그에 맞는 반응을 하는 컴포넌트


## 사용 이점

**결합도 감소**
컴포넌트들이 서로 직접적으로 의존하지 않고 이벤트를 통해 통신하기 때문에 코드의 결합도가 낮아진다.

**재사용성 향상**
이벤트를 통해 통신하면, 특정 이벤트를 수신할 수 있는 모든 컴포넌트에 동일한 방식으로 데이터를 전달할 수 있어 컴포넌트의 재사용성이 증가한다.

**유지보수 용이성**
이벤트 기반 통신은 시스템의 각 부분을 독립적으로 수정하거나 업데이트를 할 수 있어 전체적인 시스템의 유지보수가 용이해진다.


## 결합도 감소하는 과정

_예시) MVC_

MVC 그룹 하나는 문제가 되지 않는다.
![](https://velog.velcdn.com/images/developer_noah/post/fa8eb47b-0fe1-4943-afe7-799cf67c7b7e/image.png)

하지만 MVC 그룹이 여러 개 생기면 그 그룹들이 서로 통신해야 하는 상황이 생긴다. 이는 컨트롤러 간에 결합도를 높인다.
![](https://velog.velcdn.com/images/developer_noah/post/5a9f3960-93a2-43ab-bac7-d70920988d14/image.png)

이벤트 버스 패턴은 결합도를 낮춘다.
![](https://velog.velcdn.com/images/developer_noah/post/521c7052-e9b0-4583-9666-70496fbe3d11/image.png)


## 사용 방법

#### 1. 이벤트 버스 생성
``` dart
import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();
```

#### 2. 이벤트 정의
``` dart
class UserLoggedInEvent {
  User user;

  UserLoggedInEvent(this.user);
}

class NewOrderEvent {
  Order order;

  NewOrderEvent(this.order);
}
```

#### 3. 리스너 등록
특정 이벤트에 대한 리스너 등록
``` dart
eventBus.on<UserLoggedInEvent>().listen((event) {
  print(event.user);
});
```
모든 이벤트에 대한 리스너 등록
``` dart
eventBus.on().listen((event) {
  print(event.runtimeType);
});
```
Dart Streams 으로 리스너 등록
``` dart
StreamSubscription loginSubscription = eventBus.on<UserLoggedInEvent>().listen((event) {
  print(event.user);
});

loginSubscription.cancel();
```

#### 4. 이벤트 발생
``` dart
User myUser = User('Mickey');
eventBus.fire(UserLoggedInEvent(myUser));
```


## 참조
[event_bus](https://pub.dev/packages/event_bus)