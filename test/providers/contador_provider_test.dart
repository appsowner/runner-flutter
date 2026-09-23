import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:runner_flutter/providers/contador_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer.test();
  });

  test('el estado inicial es 0', () {
    expect(container.read(contadorProvider), 0);
  });

  test('incrementar suma 1 en cada llamada', () {
    final notifier = container.read(contadorProvider.notifier);

    notifier.incrementar();
    expect(container.read(contadorProvider), 1);

    notifier.incrementar();
    expect(container.read(contadorProvider), 2);
  });

  test('decrementar desde 0 da -1', () {
    container.read(contadorProvider.notifier).decrementar();
    expect(container.read(contadorProvider), -1);
  });

  test('incrementar y luego decrementar vuelve a 0', () {
    final notifier = container.read(contadorProvider.notifier);

    notifier.incrementar();
    notifier.decrementar();
    expect(container.read(contadorProvider), 0);
  });

  test('los listeners reciben cada cambio', () {
    final cambios = <(int?, int)>[];
    container.listen<int>(
      contadorProvider,
      (prev, next) => cambios.add((prev, next)),
    );
    final notifier = container.read(contadorProvider.notifier);

    notifier.incrementar();
    notifier.incrementar();
    notifier.decrementar();

    expect(cambios, [(0, 1), (1, 2), (2, 1)]);
  });
}
