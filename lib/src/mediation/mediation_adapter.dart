import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

/// Base class for creating custom mediation adapters.
///
/// Clients should extend this class to implement their own mediation logic
/// for different ad networks. Override [init] to perform any necessary
/// initialization.
///
abstract class MediationAdapter {
  @protected
  late final Logger log = Logger('Mediation ($runtimeType)');

  @mustCallSuper
  Future<void> init() async {
    log.info('Initializing mediation');
  }
}
