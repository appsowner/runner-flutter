import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Contador entero con estado inicial 0.
class ContadorNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void incrementar() => state++;

  void decrementar() => state--;
}

final contadorProvider = NotifierProvider<ContadorNotifier, int>(
  ContadorNotifier.new,
);
