import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

abstract class MediationAdapter<T> {
  @protected
  late final Logger log = Logger('Mediation ($runtimeType)');

  @mustCallSuper
  Future<void> init() async {
    log.info('Initializing mediation');
  }
}
