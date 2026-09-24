import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Contador entero con estado inicial 0.
class ContadorNotifier extends Notifier<int> {
  @override
  int build() => 0;

  void incrementar() => state++;

  /// Resta 1 al contador. El contador nunca baja de 0: en 0 no hace nada.
  void decrementar() {
    if (state > 0) state--;
  }

  /// Duplica el valor actual del contador.
  void multiplicarPorDos() => state = state * 2;
}

final contadorProvider = NotifierProvider<ContadorNotifier, int>(
  ContadorNotifier.new,
);
