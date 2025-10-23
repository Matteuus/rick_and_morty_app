import 'package:flutter/foundation.dart';
import 'package:rick_and_morty_app/core/utils/result.dart';

typedef CommandAction0<T> = Future<Result<T>> Function();
typedef CommandAction1<T, A> = Future<Result<T>> Function(A);

abstract class Command<T> extends ChangeNotifier {
  Command();
  bool _running = false;
  Result<T>? _result;

  bool get running => _running;

  bool get failure => _result is Failure;

  String? get errorMessage {
    if (_result is Failure) {
      return (_result as Failure).error;
    }
    return null;
  }

  bool get success => _result is Success;

  Future<void> _execute(CommandAction0<T> action) async {
    if (_running) return;

    _running = true;
    _result = null;
    notifyListeners();

    try {
      _result = await action();
    } finally {
      _running = false;
      notifyListeners();
    }
  }
}

class Command0<T> extends Command<T> {
  Command0(this._action);

  final CommandAction0<T> _action;

  Future<void> execute() async {
    await _execute(_action);
  }
}

class Command1<T, A> extends Command<T> {
  Command1(this._action);

  final CommandAction1<T, A> _action;

  Future<void> execute(A arg) async {
    await _execute(() => _action(arg));
  }
}
