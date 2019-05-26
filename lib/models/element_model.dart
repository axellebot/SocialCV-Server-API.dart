import 'package:social_cv_api/social_cv_api.dart';

enum ElementPresentation {
  private,
  public,
}

class ElementManagedObject<T extends ElementTableDefinition>
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

class ElementTableDefinition {
  @Column(name: 'presentation')
  ElementPresentation presentation;

  @Column(name: 'updated_at')
  DateTime updatedAt;

  @Column(name: 'created_at')
  DateTime createdAt;

  @Column(name: 'version')
  int version;
}
