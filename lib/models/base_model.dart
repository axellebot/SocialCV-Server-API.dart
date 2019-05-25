import 'package:social_cv_api/social_cv_api.dart';

class BaseManagedObject<T extends BaseTableDefinition>
    extends ManagedObject<T> {
  @override
  void willInsert() {
    (this as T).createdAt = DateTime.now().toUtc();
    (this as T).version = 0;
  }

  @override
  void willUpdate() {
    (this as T).updatedAt = DateTime.now().toUtc();
    (this as T).version++;
  }
}

class BaseTableDefinition {
  @Column(name: 'updated_at')
  DateTime updatedAt;

  @Column(name: 'created_at')
  DateTime createdAt;

  @Column(name: 'version')
  int version;
}
