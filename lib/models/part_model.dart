import 'package:social_cv_api/social_cv_api.dart';

class Part extends BaseManagedObject<_Part> implements _Part {}

@Table(name: 'parts')
class _Part extends BaseTableDefinition {
  @primaryKey
  int id;

  @Column(name:'type')
  String type;

  ManagedSet<ProfilePartJoin> profileParts;

  ManagedSet<PartGroupJoin> partGroups;

  @Relate(#parts)
  User owner;
}
