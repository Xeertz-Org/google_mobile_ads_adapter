## 1.0.0

**Breaking Changes**

- Removed direct dependency on specific mediation adapters.
  Clients must now provide their own mediation adapter implementations to the `AdsController`.
- Added support for `BannerAd`, which required adding the `BuildContext` parameter to the `load` method.
- Updated example.

## 0.0.1

- Initial version.
