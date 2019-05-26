import 'package:social_cv_api/social_cv_api.dart';

class PartGroupJoin extends ManagedObject<_PartGroupJoin>
    implements _PartGroupJoin {}

@Table(name: 'parts_groups')
class _PartGroupJoin {
  @primaryKey
  int id;

  @Relate(#partsGroups)
  Part part;

  @Relate(#partsGroups)
  Group group;
}
