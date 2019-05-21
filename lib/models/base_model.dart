import 'package:social_cv_api/social_cv_api.dart';

const Column uidPrimaryKey = Column(
    primaryKey: true,
    databaseType: ManagedPropertyType.string,
    validators: [Validate.constant()]);

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
  @Column()
  DateTime updatedAt;

  @Column()
  DateTime createdAt;

  @Column()
  int version;
}
