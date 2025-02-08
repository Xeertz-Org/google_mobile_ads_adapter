import 'package:gma_mediation_liftoffmonetize/gma_mediation_liftoffmonetize.dart';
import 'package:google_mobile_ads_adapter/src/mediation/mediation_adapter.dart';

class LiftoffmonetizeAdapter extends MediationAdapter {
  final GmaMediationLiftoffmonetize _mediation;

  LiftoffmonetizeAdapter({
    GmaMediationLiftoffmonetize? mediation,
  }) : _mediation = mediation ?? GmaMediationLiftoffmonetize();

  @override
  Future<void> init() async {
    await super.init();
    await _mediation.setGDPRStatus(true, '1.0.0');
    await _mediation.setCCPAStatus(true);
  }
}
