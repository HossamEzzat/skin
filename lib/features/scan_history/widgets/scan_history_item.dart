import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:skin/features/scan_history/domain/entities/scan_history_entity.dart';

class ScanHistoryItem extends StatelessWidget {
  final ScanHistoryEntity scan;
  final VoidCallback onDelete;

  const ScanHistoryItem({
    super.key,
    required this.scan,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('MMM dd, yyyy • hh:mm a');

    return Dismissible(
      key: Key(scan.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: theme.colorScheme.error,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.centerRight,
        child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
      ),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Icon based on scan type
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: _getScanTypeColor(theme).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _getScanTypeIcon(),
                color: _getScanTypeColor(theme),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            // Scan details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getScanTypeLabel(),
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    scan.predictionLabel,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    dateFormat.format(scan.timestamp),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            // Confidence badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: _getConfidenceColor(theme).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${(scan.confidence * 100).toStringAsFixed(0)}%',
                style: theme.textTheme.labelLarge?.copyWith(
                  color: _getConfidenceColor(theme),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getScanTypeIcon() {
    return scan.scanType == 'skin_cancer'
        ? Icons.document_scanner_rounded
        : Icons.local_fire_department_rounded;
  }

  String _getScanTypeLabel() {
    return scan.scanType == 'skin_cancer' ? 'Skin Cancer Scan' : 'Burn Scan';
  }

  Color _getScanTypeColor(ThemeData theme) {
    return scan.scanType == 'skin_cancer'
        ? theme.colorScheme.primary
        : Colors.orange;
  }

  Color _getConfidenceColor(ThemeData theme) {
    if (scan.confidence >= 0.8) {
      return Colors.green;
    } else if (scan.confidence >= 0.6) {
      return Colors.orange;
    } else {
      return theme.colorScheme.error;
    }
  }
}
