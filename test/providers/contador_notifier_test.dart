import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:runner_flutter/providers/contador_provider.dart';

void main() {
  group('ContadorNotifier', () {
    late ProviderContainer container;
    late ContadorNotifier notifier;

    int estado() => container.read(contadorProvider);

    setUp(() {
      container = ProviderContainer.test();
      notifier = container.read(contadorProvider.notifier);
    });

    test('el estado inicial es 0', () {
      expect(estado(), 0);
    });

    test('incrementar pasa de 0 a 1', () {
      notifier.incrementar();
      expect(estado(), 1);
    });

    test('dos incrementar llegan a 2', () {
      notifier
        ..incrementar()
        ..incrementar();
      expect(estado(), 2);
    });

    test('incrementar y luego decrementar vuelve a 0', () {
      notifier
        ..incrementar()
        ..decrementar();
      expect(estado(), 0);
    });

    test('decrementar desde 2 da 1', () {
      notifier
        ..incrementar()
        ..incrementar()
        ..decrementar();
      expect(estado(), 1);
    });

    test('decrementar en 0 no baja de 0, aunque se repita', () {
      notifier.decrementar();
      expect(estado(), 0);

      notifier.decrementar();
      expect(estado(), 0);
    });

    test('tras varios decrementar en 0, un incrementar da 1', () {
      notifier
        ..decrementar()
        ..decrementar()
        ..decrementar()
        ..incrementar();
      expect(estado(), 1);
    });

    test('decrementar en 0 no notifica a los listeners', () {
      final cambios = <(int?, int)>[];
      container.listen<int>(
        contadorProvider,
        (prev, next) => cambios.add((prev, next)),
      );

      notifier.decrementar();

      expect(cambios, isEmpty);
    });
  });
}
