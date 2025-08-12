import 'package:flutter/material.dart';

class KycStep1Screen extends StatefulWidget {
  const KycStep1Screen({super.key});

  @override
  State<KycStep1Screen> createState() => _KycStep1ScreenState();
}

class _KycStep1ScreenState extends State<KycStep1Screen> {
  // State for the radio button selection
  String? _selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: const Icon(Icons.arrow_back, color: Colors.black),
        title: const Text(
          'KYC',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              // --- Stepper Widget ---
              const KYCStepper(),
              const SizedBox(height: 32),
              // --- Main Content Card ---
              Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.1),
                      spreadRadius: 5,
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Données personnelles',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'S’il vous entrer vos informations personnelles telles qu’elles figurent sur votre pièce d’identité nationale.',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 24),
                    // --- Form Fields ---
                    _buildTextField(label: 'Prénom'),
                    const SizedBox(height: 16),
                    _buildTextField(label: 'Nom'),
                    const SizedBox(height: 16),
                    _buildTextField(label: 'Date de naissance'),
                    const SizedBox(height: 24),
                    // --- Gender Radio Buttons ---
                    const Text(
                      'Genre',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _buildGenderOption('Homme'),
                        const SizedBox(width: 24),
                        _buildGenderOption('Femme'),
                        const SizedBox(width: 24),
                        _buildGenderOption('Autre'),
                      ],
                    ),
                    const SizedBox(height: 32),
                    // --- Validation Button ---
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle validation logic
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFE8B33B),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 2,
                        ),
                        child: const Text(
                          'Valider',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper widget for text fields to reduce repetition
  Widget _buildTextField({required String label}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[300]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFFE8B33B), width: 2),
            ),
          ),
        ),
      ],
    );
  }

  // Helper widget for gender radio buttons
  Widget _buildGenderOption(String title) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = title;
        });
      },
      child: Row(
        children: [
          Radio<String>(
            value: title,
            groupValue: _selectedGender,
            onChanged: (String? value) {
              setState(() {
                _selectedGender = value;
              });
            },
            activeColor: const Color(0xFFE8B33B),
          ),
          Text(title, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}

// Custom widget for the stepper at the top
class KYCStepper extends StatelessWidget {
  const KYCStepper({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildStep(number: '1', title: 'Données personnelles', isActive: true),
        _buildConnector(),
        _buildStep(number: '2', title: 'Residence'),
        _buildConnector(),
        _buildStep(number: '3', title: 'Carte Identité'),
        _buildConnector(),
        _buildStep(number: '4', title: 'Compte Paiement'),
        _buildConnector(),
        _buildStep(number: '5', title: 'Selfie'),
        _buildConnector(),
        _buildStep(number: '6', title: 'Selfie+ ID Card'),
      ],
    );
  }

  // Helper for a single step in the stepper
  Widget _buildStep({
    required String number,
    required String title,
    bool isActive = false,
  }) {
    return Column(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFE8B33B) : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: TextStyle(
                color: isActive ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          title.replaceAll(' ', '\n'), // Wrap text if needed
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 12,
            color: isActive ? Colors.black : Colors.grey[600],
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // Helper for the line connecting the steps
  Widget _buildConnector() {
    return Expanded(
      child: Container(
        height: 2,
        color: Colors.grey[300],
        margin: const EdgeInsets.only(bottom: 28), // Align with circles
      ),
    );
  }
}
