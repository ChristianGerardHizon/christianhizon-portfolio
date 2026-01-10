import 'package:flutter/material.dart';

class PageActions extends StatelessWidget {
  const PageActions({
    super.key,
    required this.size,
    this.onDelete,
    this.onReset,
  });

  final int size;
  final Function()? onDelete;
  final Function()? onReset;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 500),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            border: Border.all(
              color: Colors.grey[300]!,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          padding: EdgeInsets.only(left: 8, right: 8, top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Selected ${size} record',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(width: 8),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: Colors.grey[300]!,
                        width: 1.0,
                      ),
                      padding: const EdgeInsets.only(
                        bottom: 8,
                        top: 8,
                        right: 8,
                        left: 8,
                      ),
                    ),
                    onPressed: onReset,
                    child: Text(
                      'Reset',
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 8),
                child: TextButton(
                  onPressed: onDelete,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.only(
                      bottom: 10,
                      top: 8,
                      right: 16,
                      left: 16,
                    ),
                  ),
                  child: Text(
                    'Delete Selected',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
