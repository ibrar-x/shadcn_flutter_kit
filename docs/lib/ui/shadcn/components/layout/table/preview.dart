import 'package:flutter/material.dart' hide Table;

import '../table/table.dart' as shadcn;

class TablePreview extends StatelessWidget {
  const TablePreview({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: SizedBox(
          width: 420,
          child: shadcn.Table(
            rows: [
              shadcn.TableHeader(
                cells: [
                  shadcn.TableCell(child: Text('Name')),
                  shadcn.TableCell(child: Text('Role')),
                  shadcn.TableCell(child: Text('Status')),
                ],
              ),
              shadcn.TableRow(
                cells: [
                  shadcn.TableCell(child: Text('Avery')),
                  shadcn.TableCell(child: Text('Designer')),
                  shadcn.TableCell(child: Text('Active')),
                ],
              ),
              shadcn.TableRow(
                cells: [
                  shadcn.TableCell(child: Text('Jordan')),
                  shadcn.TableCell(child: Text('Engineer')),
                  shadcn.TableCell(child: Text('Active')),
                ],
              ),
              shadcn.TableRow(
                cells: [
                  shadcn.TableCell(child: Text('Casey')),
                  shadcn.TableCell(child: Text('PM')),
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
