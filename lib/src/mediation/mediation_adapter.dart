import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

abstract class MediationAdapter<T> {
  @protected
  late final Logger log = Logger('Mediation ($runtimeType)');

  @mustCallSuper
  Future<void> init() async {
    log.info('Initializing mediation');
  }
}
