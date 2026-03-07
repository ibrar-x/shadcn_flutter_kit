import 'package:flutter/material.dart' hide Table;

import '../table/table.dart' as shadcn;

/// TablePreview defines a reusable type for this registry module.
class TablePreview extends StatelessWidget {
  const TablePreview({super.key});

  @override
/// Executes `build` behavior for this component/composite.
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 420,
          child: shadcn.Table(
            rows: [
/// Creates a `shadcn.TableHeader` instance.
              shadcn.TableHeader(
                cells: [
/// Creates a `shadcn.TableCell` instance.
                  shadcn.TableCell(child: Text('Name')),
/// Creates a `shadcn.TableCell` instance.
                  shadcn.TableCell(child: Text('Role')),
/// Creates a `shadcn.TableCell` instance.
                  shadcn.TableCell(child: Text('Status')),
                ],
              ),
/// Creates a `shadcn.TableRow` instance.
              shadcn.TableRow(
                cells: [
/// Creates a `shadcn.TableCell` instance.
                  shadcn.TableCell(child: Text('Avery')),
/// Creates a `shadcn.TableCell` instance.
                  shadcn.TableCell(child: Text('Designer')),
/// Creates a `shadcn.TableCell` instance.
                  shadcn.TableCell(child: Text('Active')),
                ],
              ),
/// Creates a `shadcn.TableRow` instance.
              shadcn.TableRow(
                cells: [
/// Creates a `shadcn.TableCell` instance.
                  shadcn.TableCell(child: Text('Jordan')),
/// Creates a `shadcn.TableCell` instance.
                  shadcn.TableCell(child: Text('Engineer')),
/// Creates a `shadcn.TableCell` instance.
                  shadcn.TableCell(child: Text('Active')),
                ],
              ),
/// Creates a `shadcn.TableRow` instance.
              shadcn.TableRow(
                cells: [
/// Creates a `shadcn.TableCell` instance.
                  shadcn.TableCell(child: Text('Casey')),
/// Creates a `shadcn.TableCell` instance.
                  shadcn.TableCell(child: Text('PM')),
/// Creates a `shadcn.TableCell` instance.
                  shadcn.TableCell(child: Text('Away')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
