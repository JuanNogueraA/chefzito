import 'package:chefzito/core/domain/ports/init_port.dart';

class InitAppUseCase {
  final InitPort _initPort;

  InitAppUseCase(this._initPort);

  Future<void> call() {
    return _initPort.init();
  }
}
