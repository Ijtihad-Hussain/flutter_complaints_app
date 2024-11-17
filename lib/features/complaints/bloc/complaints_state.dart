import '../../../models/complaint_model.dart';

abstract class ComplaintsState {}

class ComplaintsLoading extends ComplaintsState {}

class ComplaintsLoaded extends ComplaintsState {
  final List<Complaint> complaints;

  ComplaintsLoaded(this.complaints);
}

class ComplaintsError extends ComplaintsState {
  final String message;

  ComplaintsError(this.message);
}

class ComplaintsFiltered extends ComplaintsState {
  final List<Complaint> complaints;

  ComplaintsFiltered(this.complaints);
}