
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/complaint_model.dart';
import 'complaints_events.dart';
import 'complaints_state.dart';

class ComplaintsBloc extends Bloc<ComplaintsEvent, ComplaintsState> {
  List<Complaint> _complaints = [];

  ComplaintsBloc() : super(ComplaintsLoading()) {
    on<LoadComplaints>((event, emit) async {
      emit(ComplaintsLoading());

      await Future.delayed(Duration(seconds: 1));
      _complaints = [
        Complaint(
          number: '12345',
          status: 'Pending',
          postName: 'Talha Ahmed',
          postDate: '2023-10-01',
          description: 'This is a description of the complaint.',
        ),
        Complaint(
          number: '12346',
          status: 'Resolved',
          postName: 'Talha Ahmed',
          postDate: '2023-10-02',
          description: 'This is another complaint description.',
        ),
      ];
      emit(ComplaintsLoaded(_complaints));
    });

    on<AddComplaint>((event, emit) {
      _complaints.add(event.complaint);
      emit(ComplaintsLoaded(_complaints));
    });

    on<EditComplaint>((event, emit) {
      _complaints[event.index] = event.complaint;
      emit(ComplaintsLoaded(_complaints));
    });

    on<SearchComplaints>((event, emit) {
      final filteredComplaints = _complaints
          .where((complaint) => complaint.description.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      emit(ComplaintsFiltered(filteredComplaints));
    });
  }
}