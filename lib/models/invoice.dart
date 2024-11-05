class Invoice {
  final String customerName;
  final String invoiceNumber;
  final DateTime date;
  final List<InvoiceItem> items;
  final double tax;
  final double total;
  final String? notes;
  final String template;

  Invoice({
    required this.customerName,
    required this.invoiceNumber,
    required this.date,
    required this.items,
    required this.tax,
    required this.total,
    this.notes,
    this.template = 'simple',
  });

  Invoice copyWith({
    String? customerName,
    String? invoiceNumber,
    DateTime? date,
    List<InvoiceItem>? items,
    double? tax,
    double? total,
    String? notes,
    String? template,
  }) {
    return Invoice(
      customerName: customerName ?? this.customerName,
      invoiceNumber: invoiceNumber ?? this.invoiceNumber,
      date: date ?? this.date,
      items: items ?? this.items,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      notes: notes ?? this.notes,
      template: template ?? this.template,
    );
  }
}

class InvoiceItem {
  final String description;
  final int quantity;
  final double unitPrice;

  InvoiceItem({
    required this.description,
    required this.quantity,
    required this.unitPrice,
  });

  double get total => quantity * unitPrice;
}
