import 'package:flutter_auth_app/models/complaint_model.dart';

abstract class ComplaintsEvent {}

class LoadComplaints extends ComplaintsEvent {}

class AddComplaint extends ComplaintsEvent {
  final Complaint complaint;

  AddComplaint(this.complaint);
}

class EditComplaint extends ComplaintsEvent {
  final int index;
  final Complaint complaint;

  EditComplaint(this.index, this.complaint);
}

class SearchComplaints extends ComplaintsEvent {
  final String query;

  SearchComplaints(this.query);
}