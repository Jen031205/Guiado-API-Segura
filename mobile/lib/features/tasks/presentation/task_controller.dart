/// Manages task list state and mutations using Riverpod.
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../../../core/network/api_client.dart';
import '../../../core/storage/token_store.dart';
import '../../auth/data/auth_repository.dart';
import '../data/task_repository.dart';
import '../domain/task.dart';

/// Provides platform secure storage for tokens.
final tokenStoreProvider = Provider<TokenStore>((ref) {
  return TokenStore(const FlutterSecureStorage());
});

/// Tracks whether the user has an active session.
class AuthStateNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  /// Marks the user as signed in.
  void signIn() => state = true;

  /// Marks the user as signed out.
  void signOut() => state = false;
}

/// Provides the current authentication state.
final authStateProvider = NotifierProvider<AuthStateNotifier, bool>(
  AuthStateNotifier.new,
);

/// Provides the shared API client with automatic refresh and session expiration handling.
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient(
    http.Client(),
    ref.read(tokenStoreProvider),
    onSessionExpired: () => ref.read(authStateProvider.notifier).signOut(),
  );
});

/// Provides the authentication repository.
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    ref.read(apiClientProvider),
    ref.read(tokenStoreProvider),
  );
});

/// Provides the task repository.
final taskRepositoryProvider = Provider<TaskRepository>((ref) {
  return TaskRepository(ref.read(apiClientProvider));
});

/// Represents the UI state for the task list screen.
class TaskState {
  /// Creates a task state.
  const TaskState({
    this.loading = false,
    this.tasks = const [],
    this.errorMessage,
  });

  /// Whether a load or mutation is in progress.
  final bool loading;

  /// Loaded tasks.
  final List<Task> tasks;

  /// Safe error message, if an operation failed.
  final String? errorMessage;

  /// Returns a copy with updated fields.
  TaskState copyWith({
    bool? loading,
    List<Task>? tasks,
    String? errorMessage,
  }) {
    return TaskState(
      loading: loading ?? this.loading,
      tasks: tasks ?? this.tasks,
      errorMessage: errorMessage,
    );
  }
}

/// Controls loading, creating, toggling, and deleting tasks.
class TaskController extends Notifier<TaskState> {
  @override
  TaskState build() {
    return const TaskState();
  }

  /// Loads the first page of tasks for the signed-in user.
  Future<void> loadTasks() async {
    state = state.copyWith(loading: true, errorMessage: null);
    try {
      final tasks = await ref.read(taskRepositoryProvider).list();
      state = TaskState(loading: false, tasks: tasks);
    } on ApiException catch (e) {
      state = state.copyWith(loading: false, errorMessage: e.message);
    } catch (_) {
      state = state.copyWith(
        loading: false,
        errorMessage: 'An unexpected error occurred.',
      );
    }
  }

  /// Creates a new task and prepends it to the list.
  Future<void> createTask(String title, String? description) async {
    try {
      final created = await ref
          .read(taskRepositoryProvider)
          .create(title, description?.isEmpty == true ? null : description);
      state = state.copyWith(tasks: [created, ...state.tasks], errorMessage: null);
    } on ApiException catch (e) {
      state = state.copyWith(errorMessage: e.message);
    }
  }

  /// Toggles a task's completion status.
  Future<void> toggleTask(Task task) async {
    try {
      final updated = await ref
          .read(taskRepositoryProvider)
          .setCompleted(task, !task.completed);
      state = state.copyWith(
        tasks: [
          for (final item in state.tasks)
            if (item.id == updated.id) updated else item,
        ],
        errorMessage: null,
      );
    } on ApiException catch (e) {
      state = state.copyWith(errorMessage: e.message);
    }
  }

  /// Deletes a task by ID.
  Future<void> deleteTask(Task task) async {
    try {
      await ref.read(taskRepositoryProvider).delete(task.id);
      state = state.copyWith(
        tasks: state.tasks.where((item) => item.id != task.id).toList(),
        errorMessage: null,
      );
    } on ApiException catch (e) {
      state = state.copyWith(errorMessage: e.message);
    }
  }
}

/// Provides the task controller and state.
final tasksProvider = NotifierProvider<TaskController, TaskState>(
  TaskController.new,
);
