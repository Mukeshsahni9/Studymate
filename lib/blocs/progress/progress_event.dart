import 'package:equatable/equatable.dart';
import '../../models/progress.dart';

abstract class ProgressEvent extends Equatable {
  const ProgressEvent();

  @override
  List<Object?> get props => [];
}

class LoadProgress extends ProgressEvent {
  const LoadProgress();
}

class UpdateProgress extends ProgressEvent {
  final Progress progress;

  const UpdateProgress(this.progress);

  @override
  List<Object?> get props => [progress];
}

class AddAchievement extends ProgressEvent {
  final String achievement;

  const AddAchievement(this.achievement);

  @override
  List<Object?> get props => [achievement];
} 