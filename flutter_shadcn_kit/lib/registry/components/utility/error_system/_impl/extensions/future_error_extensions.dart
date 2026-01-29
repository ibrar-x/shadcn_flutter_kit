import '../core/app_error.dart';
import '../core/error_mapper.dart';

extension FutureErrorExtensions<T> on Future<T> {
  Future<T> mapError(ErrorMapper mapper) async {
    try {
      return await this;
    } catch (error, stackTrace) {
      throw mapper.map(error, stackTrace);
    }
  }

  Future<T> onAppError(void Function(AppError error) handler) async {
    try {
      return await this;
    } catch (error) {
      if (error is AppError) {
        handler(error);
      }
      rethrow;
    }
  }
}
