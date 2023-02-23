import '../../models/version_response_model.dart';

abstract class VersionComparatorState {
  const VersionComparatorState();
}

class VersionComparatorInitialState extends VersionComparatorState {
  const VersionComparatorInitialState();
}

class VersionComparatorLoadingState extends VersionComparatorState {
  const VersionComparatorLoadingState();
}

class VersionComparatorSuccessState extends VersionComparatorState {
  const VersionComparatorSuccessState(this.data);

  final VersionResponseModel data;
}

class VersionComparatorErrorState extends VersionComparatorState {
  const VersionComparatorErrorState({required this.message, this.data, required this.isOldVersionError});

  final String message;
  final bool isOldVersionError;
  final VersionResponseModel? data;
}
