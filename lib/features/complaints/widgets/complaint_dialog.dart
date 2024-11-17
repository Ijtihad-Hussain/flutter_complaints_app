import 'package:flutter/material.dart';
import 'package:flutter_auth_app/constants/app_colors.dart';

import '../../../models/complaint_model.dart';

class ComplaintDialog extends StatelessWidget {
  final Complaint? complaint;
  final Function(Complaint) onSubmit;
  final String title;

  const ComplaintDialog({
    super.key,
    this.complaint,
    required this.onSubmit,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final TextEditingController postNameController =
        TextEditingController(text: complaint?.postName);
    final TextEditingController descriptionController =
        TextEditingController(text: complaint?.description);

    return AlertDialog(
      title: Center(child: Text(title)),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: postNameController,
              decoration: InputDecoration(
                  labelText: 'category',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.orangeButton),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.white),
            ),
            SizedBox(height: 20,),
            TextField(
              maxLines: 5,
              controller: descriptionController,
              decoration: InputDecoration(
                  labelText: 'Details',
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.orangeButton),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  filled: true,
                  fillColor: Colors.white),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            final newComplaint = Complaint(
              number: '7834874',
              status: 'Pending',
              postName: postNameController.text,
              postDate: '12:9:2022',
              description: descriptionController.text,
            );
            onSubmit(newComplaint);
            Navigator.of(context).pop();
          },
          child: Text(complaint == null ? 'Submit' : 'Save'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
      ],
    );
  }
}
