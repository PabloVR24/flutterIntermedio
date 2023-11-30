import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sensors_plus/sensors_plus.dart';

class GiroscopeXYZ {
  final double x;
  final double y;
  final double z;

  GiroscopeXYZ(this.x, this.y, this.z);

  @override
  String toString() {
    return '''
           x:$x,
           y:$y,
           z:$z
           ''';
  }
}

final giroscopeProvider = StreamProvider.autoDispose<GiroscopeXYZ>((ref) async* {
  await for (final event in gyroscopeEvents) {
    final x = double.parse(event.x.toStringAsFixed(2));
    final y = double.parse(event.y.toStringAsFixed(2));
    final z = double.parse(event.z.toStringAsFixed(2));
    yield GiroscopeXYZ(x, y, z);
  }
});
