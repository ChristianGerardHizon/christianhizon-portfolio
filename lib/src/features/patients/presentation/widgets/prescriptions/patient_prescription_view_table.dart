import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gym_system/src/features/patients/domain/prescription/patient_prescription_item_create.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// Define the PrescriptionItem class

class PrescriptionViewTable extends HookConsumerWidget {
  final String id;
  const PrescriptionViewTable({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptions = useState<List<PrescriptionItemCreate>>([]);

    final textControllers = useState<List<List<TextEditingController>>>(
      prescriptions.value
          .map(
            (item) => [
              TextEditingController(text: item.medication),
              TextEditingController(text: item.dosage),
              TextEditingController(text: item.instruction),
            ],
          )
          .toList(),
    );

    final focusNodes = useState<List<List<FocusNode>>>(
      prescriptions.value
          .map((_) => [FocusNode(), FocusNode(), FocusNode()])
          .toList(),
    );

    void addPrescription({bool focusOnNew = false}) {
      prescriptions.value = [
        ...prescriptions.value,
        PrescriptionItemCreate(
          patientRecord: id,
          medication: null,
          dosage: null,
          instruction: null,
        ),
      ];

      textControllers.value = [
        ...textControllers.value,
        [
          TextEditingController(),
          TextEditingController(),
          TextEditingController(),
        ],
      ];

      focusNodes.value = [
        ...focusNodes.value,
        [FocusNode(), FocusNode(), FocusNode()]
      ];

      if (focusOnNew) {
        Future.delayed(const Duration(milliseconds: 100), () {
          FocusScope.of(context).requestFocus(
              focusNodes.value.last[0]); // Focus on new row's medication field
        });
      }
    }

    void deletePrescription(int index) {
      if (prescriptions.value.length == 1)
        return; // Prevent deleting the last item

      final updatedList = List<PrescriptionItemCreate>.from(prescriptions.value)
        ..removeAt(index);
      final updatedControllers =
          List<List<TextEditingController>>.from(textControllers.value)
            ..removeAt(index);
      final updatedFocusNodes = List<List<FocusNode>>.from(focusNodes.value)
        ..removeAt(index);

      prescriptions.value = updatedList;
      textControllers.value = updatedControllers;
      focusNodes.value = updatedFocusNodes;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Prescription Table')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FixedColumnWidth(50), // Row number
                  1: FlexColumnWidth(),
                  2: FlexColumnWidth(),
                  3: FlexColumnWidth(),
                  4: FixedColumnWidth(60), // Delete button
                },
                children: [
                  // Header Row
                  TableRow(
                    decoration: BoxDecoration(color: Colors.grey[300]),
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("#",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Medication",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Dosage",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Instruction",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      SizedBox(), // Empty cell for delete button
                    ],
                  ),
                  // Data Rows
                  ...prescriptions.value.asMap().entries.map(
                    (entry) {
                      final index = entry.key;
                      final isLastRow = index == prescriptions.value.length - 1;
                      return TableRow(
                        children: [
                          // Row number column
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text("${index + 1}",
                                textAlign: TextAlign.center),
                          ),
                          for (int i = 0; i < 3; i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8.0),
                              child: TextField(
                                controller: textControllers.value[index][i],
                                focusNode: focusNodes.value[index][i],
                                minLines: 1,
                                maxLines: 5,
                                decoration: const InputDecoration(
                                    border: InputBorder.none),
                                onChanged: (value) {
                                  final updatedList =
                                      List<PrescriptionItemCreate>.from(
                                          prescriptions.value);
                                  final createParam = updatedList[index];
                                  if (i == 0)
                                    createParam.copyWith(medication: value);
                                  if (i == 1)
                                    createParam.copyWith(dosage: value);
                                  if (i == 2)
                                    createParam.copyWith(instruction: value);
                                  prescriptions.value = updatedList;
                                },
                              ),
                            ),
                          Center(
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => deletePrescription(index),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  // "Add Prescription" Button
                  TableRow(
                    children: [
                      const SizedBox(), // Empty column for numbering
                      TextButton(
                        onPressed: () => addPrescription(focusOnNew: true),
                        child: const Text("Add Prescription"),
                      ),
                      const SizedBox(),
                      const SizedBox(),
                      const SizedBox(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
