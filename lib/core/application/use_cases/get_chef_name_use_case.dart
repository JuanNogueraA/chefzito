import 'package:chefzito/core/domain/ports/chef_name_port.dart';

class GetChefNameUseCase {
  final ChefNamePort _chefNamePort;

  GetChefNameUseCase(this._chefNamePort);

  String call() {
    return _chefNamePort.currentChefName;
  }
}
