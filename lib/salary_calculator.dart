class SalaryCalculator {
  int hours;
  int overtimeHours;
  double rate;
  double overtimeMultiplier;
  double taxPercent;

  SalaryCalculator({
    required this.hours,
    required this.overtimeHours,
    required this.rate,
    required this.overtimeMultiplier,
    required this.taxPercent,
  });

  double get baseSalary {
    return hours * rate;
  }

  double get overtimePay {
    return overtimeHours * rate * overtimeMultiplier;
  }

  double get grossSalary {
    return baseSalary + overtimePay;
  }

  double get taxAmount {
    return grossSalary * (taxPercent / 100.0);
  }

  double get netSalary {
    return grossSalary - taxAmount;
  }

  @override
  String toString() {
    return "Base: ${baseSalary.toStringAsFixed(2)} | "
        "Overtime: ${overtimePay.toStringAsFixed(2)} | "
        "Gross: ${grossSalary.toStringAsFixed(2)} | "
        "Tax: ${taxAmount.toStringAsFixed(2)} | "
        "Net: ${netSalary.toStringAsFixed(2)}";
  }
}
