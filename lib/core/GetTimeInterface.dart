abstract class GetTimeInterface {
  DateTime now();
}

class GetTimeInterfaceImpl {
  DateTime now() {
    return DateTime.now();
  }
}