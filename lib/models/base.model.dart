/// It's an abstract class that has two abstract methods,
/// one that returns a map of strings and objects
/// and another that takes a map of strings and objects and returns a generic
/// type
abstract class BaseModel<T> {
  /// A method that returns a map of strings and objects.
  Map<String, dynamic> toJson();

  /// A method that takes a map of strings and objects and returns a generic
  /// type.
  T fromJson(Map<String, dynamic> json);
}
