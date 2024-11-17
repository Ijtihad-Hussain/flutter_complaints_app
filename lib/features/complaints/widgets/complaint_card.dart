
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../models/complaint_model.dart';

class ComplaintCard extends StatelessWidget {
  final Complaint complaint;
  final VoidCallback onEdit;

  const ComplaintCard({
    super.key,
    required this.complaint,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row for Complaint Number and Status Button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Complaint Number',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4), // Space between text and number
                    Text(
                      complaint.number,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.orangeButton),
                  onPressed: () {},
                  child: Text(complaint.status),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(complaint.postName),
                Text(complaint.postDate),
              ],
            ),
            SizedBox(height: 16), // Space between sections
            // Complaint Description
            Text(
              'Complaint Description',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 4), // Space between title and description
            Text(complaint.description),
            SizedBox(height: 16), // Space at the bottom
            // Edit Button
            Align(
              alignment: Alignment .centerRight,
              child: ElevatedButton(
                onPressed: onEdit,
                child: Text('Edit Complaint'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}