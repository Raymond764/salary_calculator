import 'package:flutter/material.dart';
import 'salary_calculator.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  // text fields
  TextEditingController hoursController = TextEditingController();
  TextEditingController overtimeController = TextEditingController();
  TextEditingController rateController = TextEditingController();


  List<double> multipliers = [1.25, 1.5, 2.0];
  double selectedMultiplier = 1.5;


  List<double> taxOptions = [0, 5, 10, 15, 20];
  double selectedTax = 10;


  String jobType = "full"; // "full" or "part"


  bool includeTax = true;


  String resultText = "";

  void calculateSalary() {
    int hours = int.tryParse(hoursController.text) ?? 0;
    int overtimeHours = int.tryParse(overtimeController.text) ?? 0;
    double rate = double.tryParse(rateController.text) ?? 0;

    if (hours <= 0 || rate <= 0) {
      setState(() {
        resultText = "Please enter valid hours and rate.";
      });
      return;
    }

    double taxPercent = includeTax ? selectedTax : 0;

    SalaryCalculator calc = SalaryCalculator(
      hours: hours,
      overtimeHours: overtimeHours,
      rate: rate,
      overtimeMultiplier: selectedMultiplier,
      taxPercent: taxPercent,
    );

    String comment;

    if (calc.netSalary < 400) {
      comment = "Net salary is low. Time to ask for a raise 😅";
    } else if (calc.netSalary < 800) {
      comment = "Decent net salary. Not bad 👍";
    } else {
      comment = "Good net salary. Treat yourself 🍔";
    }

    String jobText = (jobType == "full") ? "Full-time" : "Part-time";

    setState(() {
      resultText =
      "Job type: $jobText\n"
          "Base salary: ${calc.baseSalary.toStringAsFixed(2)}\n"
          "Overtime pay: ${calc.overtimePay.toStringAsFixed(2)}\n"
          "Gross salary: ${calc.grossSalary.toStringAsFixed(2)}\n"
          "Tax (${taxPercent.toStringAsFixed(0)}%): ${calc.taxAmount.toStringAsFixed(2)}\n"
          "Net salary: ${calc.netSalary.toStringAsFixed(2)}\n\n"
          "$comment";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Overtime & Salary Calculator"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [

              SizedBox(height: 20),

              Text(
                "Enter your work details",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              SizedBox(height: 20),

              // Hours
              SizedBox(
                width: 250,
                child: TextField(
                  controller: hoursController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Regular hours",
                    hintText: "e.g. 160",
                  ),
                ),
              ),

              SizedBox(height: 15),

              // Overtime hours
              SizedBox(
                width: 250,
                child: TextField(
                  controller: overtimeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Overtime hours",
                    hintText: "e.g. 10",
                  ),
                ),
              ),

              SizedBox(height: 15),

              // Hourly rate
              SizedBox(
                width: 250,
                child: TextField(
                  controller: rateController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Hourly rate",
                    hintText: "e.g. 5.5",
                  ),
                ),
              ),

              SizedBox(height: 20),


              Text(
                "Job type:",
                style: TextStyle(fontSize: 16),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                    value: "full",
                    groupValue: jobType,
                    onChanged: (String? value) {
                      setState(() {
                        jobType = value ?? "full";
                      });
                    },
                  ),
                  Text("Full-time"),
                  Radio<String>(
                    value: "part",
                    groupValue: jobType,
                    onChanged: (String? value) {
                      setState(() {
                        jobType = value ?? "part";
                      });
                    },
                  ),
                  Text("Part-time"),
                ],
              ),

              SizedBox(height: 10),


              Text(
                "Overtime multiplier:",
                style: TextStyle(fontSize: 16),
              ),

              DropdownButton<double>(
                value: selectedMultiplier,
                items: multipliers.map((double m) {
                  return DropdownMenuItem<double>(
                    value: m,
                    child: Text("${m}x"),
                  );
                }).toList(),
                onChanged: (double? newVal) {
                  setState(() {
                    selectedMultiplier = newVal ?? 1.5;
                  });
                },
              ),

              SizedBox(height: 10),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(
                    value: includeTax,
                    onChanged: (bool? value) {
                      setState(() {
                        includeTax = value ?? true;
                      });
                    },
                  ),
                  Text("Include tax"),
                  SizedBox(width: 10),
                  DropdownButton<double>(
                    value: selectedTax,
                    items: taxOptions.map((double t) {
                      return DropdownMenuItem<double>(
                        value: t,
                        child: Text("${t.toStringAsFixed(0)}%"),
                      );
                    }).toList(),
                    onChanged: includeTax
                        ? (double? newVal) {
                      setState(() {
                        selectedTax = newVal ?? 10;
                      });
                    }
                        : null,
                  ),
                ],
              ),

              SizedBox(height: 20),

              ElevatedButton(
                onPressed: calculateSalary,
                child: Text(
                  "Calculate",
                  style: TextStyle(fontSize: 18),
                ),
              ),

              SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  resultText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
