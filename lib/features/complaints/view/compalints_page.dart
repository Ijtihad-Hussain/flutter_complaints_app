import 'package:flutter/material.dart';
import 'package:flutter_auth_app/constants/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/complaint_model.dart';
import '../bloc/complaints_bloc.dart';
import '../bloc/complaints_events.dart';
import '../bloc/complaints_state.dart';
import '../widgets/complaint_card.dart';
import '../widgets/complaint_dialog.dart';

class ComplaintsPage extends StatelessWidget {
  const ComplaintsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ComplaintsBloc()..add(LoadComplaints()),
      child: Scaffold(
        body: BlocBuilder<ComplaintsBloc, ComplaintsState>(
          builder: (context, state) {
            if (state is ComplaintsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is ComplaintsLoaded || state is ComplaintsFiltered) {
              final complaints = (state is ComplaintsFiltered)
                  ? state.complaints
                  : (state as ComplaintsLoaded).complaints;

              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.orangeButton,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40),
                      ),
                    ),
                    padding: EdgeInsets.only(top: 60, bottom: 16, left: 16, right: 16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Create your\n',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.normal, // You can change this to bold if needed
                                        ),
                                      ),
                                      TextSpan(
                                        text: 'Complaints', // New line after "Complaints"
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Have something to rant about?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                              child: IconButton(
                                icon: Icon(Icons.add, color: Colors.blueAccent),
                                onPressed: () {
                                  _showAddDialog(context);
                                },
                              ),
                            ),
                          ],
                        ),
                        // Search bar
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: TextField(
                            onChanged: (query) {
                              context.read<ComplaintsBloc>().add(SearchComplaints(query));
                            },
                            decoration: InputDecoration(
                              hintText: 'Search complaints...',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              prefixIcon: Icon(Icons.search),
                              filled: true,
                              fillColor: Colors.white
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'SORT BY DATE ADDED',
                          style: TextStyle(color: AppColors.orangeButton),
                        ),
                      ),
                      Icon(Icons.expand_more_outlined, color: AppColors.orangeButton,)
                    ],
                  ),
                  SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: complaints.length,
                      itemBuilder: (context, index) {
                        return ComplaintCard(
                          complaint: complaints[index],
                          onEdit: () {
                            _showEditDialog(context, index, complaints[index]);
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is ComplaintsError) {
              return Center(child: Text(state.message));
            }
            return Container();
          },
        ),
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return ComplaintDialog(
          title: 'New Complaint',
          onSubmit: (newComplaint) {
            context.read<ComplaintsBloc>().add(AddComplaint(newComplaint));
          },
        );
      },
    );
  }

  void _showEditDialog(BuildContext context, int index, Complaint complaint) {
    showDialog(
      context: context,
      builder: (context) {
        return ComplaintDialog(
          title: 'Edit Complaint',
          complaint: complaint,
          onSubmit: (updatedComplaint) {
            context.read<ComplaintsBloc>().add(EditComplaint(index, updatedComplaint));
          },
        );
      },
    );
  }
}