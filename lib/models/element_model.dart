import 'package:social_cv_api/social_cv_api.dart';

enum ElementPresentation {
  private,
  public,
}

abstract class ElementManagedObject<T extends ElementTableDefinition>
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

abstract class ElementTableDefinition {
  @primaryKey
  int id;

  @Column()
  Document tags;

  @Column()
  ElementPresentation presentation;

  @Serialize(input: false, output: false)
  User owner;

  @Serialize(input: false, output: true)
  @Column()
  DateTime updatedAt;

  @Serialize(input: false, output: true)
  @Column()
  DateTime createdAt;

  @Serialize(input: false, output: true)
  @Column()
  int version;
}
