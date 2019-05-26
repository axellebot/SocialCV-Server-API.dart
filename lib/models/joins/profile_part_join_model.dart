import 'package:social_cv_api/social_cv_api.dart';

class ProfilePartJoin extends ManagedObject<_ProfilePartJoin>
    implements _ProfilePartJoin {}

@Table(name: 'profiles_groups')
class _ProfilePartJoin {
  @primaryKey
  int id;

  @Relate(#profilesParts)
  Profile profile;

  @Relate(#profilesParts)
  Part part;
}
