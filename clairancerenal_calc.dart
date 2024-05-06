import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ClairanceRenal extends StatefulWidget {
  const ClairanceRenal({Key? key}) : super(key: key);

  @override
  _ClairanceRenalState createState() => _ClairanceRenalState();
}

class _ClairanceRenalState extends State<ClairanceRenal> {
  TextEditingController weightController = TextEditingController();
  TextEditingController serumCreatinineController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  bool isMale = true;
  double creatinineClearance = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Clairance Renal',
          style: GoogleFonts.robotoSerif(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: weightController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Weight (kg)',
                          border: InputBorder.none,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: serumCreatinineController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Serum Creatinine (mg/dL)',
                          border: InputBorder.none,
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: ageController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Age (years)',
                          border: InputBorder.none,
                        ),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Text('Gender:'),
                          Radio(
                            value: true,
                            groupValue: isMale,
                            onChanged: (value) {
                              setState(() {
                                isMale = value as bool;
                              });
                            },
                          ),
                          Text('Male'),
                          Radio(
                            value: false,
                            groupValue: isMale,
                            onChanged: (value) {
                              setState(() {
                                isMale = value as bool;
                              });
                            },
                          ),
                          Text('Female'),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    double weight = double.tryParse(weightController.text) ?? 0;
                    double serumCreatinine = double.tryParse(serumCreatinineController.text) ?? 0;
                    int age = int.tryParse(ageController.text) ?? 0;

                    setState(() {
                      creatinineClearance = calculateCreatinineClearance(weight, serumCreatinine, age, isMale);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue[200],
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              icon: Icon(Icons.calculate_rounded, size: 30),
              label: Text(
                'Calculate',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
                SizedBox(height: 16),
                Text(
                  'Creatinine Clearance: ${creatinineClearance.toStringAsFixed(2)} mL/min',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double calculateCreatinineClearance(double weight, double serumCreatinine, int age, bool isMale) {
    double constant = isMale ? 1 : 0.85;

    if (weight <= 0 || serumCreatinine <= 0 || age <= 0) {
      return 0;
    }

    double creatinineClearance = ((140 - age) * weight * constant) / (serumCreatinine * 72);
    return creatinineClearance;
  }
}
