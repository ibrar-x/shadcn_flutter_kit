import 'package:flutter/material.dart' hide Table;

import '../table/table.dart' as shadcn;

class TablePreview extends StatelessWidget {
  const TablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 420,
          child: shadcn.Table(
            rows: [
              shadcn.TableHeader(
                cells: [
                  shadcn.TableCell(child: const Text('Name')),
                  shadcn.TableCell(child: const Text('Role')),
                  shadcn.TableCell(child: const Text('Status')),
                ],
              ),
              shadcn.TableRow(
                cells: [
                  shadcn.TableCell(child: const Text('Avery')),
                  shadcn.TableCell(child: const Text('Designer')),
                  shadcn.TableCell(child: const Text('Active')),
                ],
              ),
              shadcn.TableRow(
                cells: [
                  shadcn.TableCell(child: const Text('Jordan')),
                  shadcn.TableCell(child: const Text('Engineer')),
                  shadcn.TableCell(child: const Text('Active')),
                ],
              ),
              shadcn.TableRow(
                cells: [
                  shadcn.TableCell(child: const Text('Casey')),
                  shadcn.TableCell(child: const Text('PM')),
                  shadcn.TableCell(child: const Text('Away')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
