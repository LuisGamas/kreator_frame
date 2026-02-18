/// Abstract interface for key-value storage operations.
///
/// Provides a type-safe abstraction over persistent storage (SharedPreferences).
/// Supports storing and retrieving primitive types: int, String, and bool.
abstract class KeyValueStorageServices {
  /// Stores a value with the given key.
  /// Supported types: int, String, bool.
  Future<void> setKeyValue<T>(String key, T value);

  /// Retrieves a value for the given key.
  /// Returns null if the key doesn't exist.
  /// Supported types: int, String, bool.
  Future<T?> getKeyValue<T>(String key);

  /// Removes a key-value pair from storage.
  /// Returns true if the key was removed successfully.
  Future<bool> removeKey(String key);
}
