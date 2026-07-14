import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/theme/app_colors.dart';
import '../../providers/user_provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController careerController;
  late TextEditingController productiveController;
  late TextEditingController screenTimeController;
  late TextEditingController bedtimeController;
  late TextEditingController wakeupController;

  bool isSaving = false;

  @override
  void initState() {
    super.initState();

    final user =
    Provider.of<UserProvider>(context, listen: false).user!;

    nameController =
        TextEditingController(text: user.name);

    careerController =
        TextEditingController(text: user.careerGoal);

    productiveController =
        TextEditingController(
          text: user.productiveHours.toString(),
        );

    screenTimeController =
        TextEditingController(
          text: user.screenTime.toString(),
        );

    bedtimeController =
        TextEditingController(text: user.bedtime);

    wakeupController =
        TextEditingController(text: user.wakeup);
  }

  @override
  void dispose() {
    nameController.dispose();
    careerController.dispose();
    productiveController.dispose();
    screenTimeController.dispose();
    bedtimeController.dispose();
    wakeupController.dispose();

    super.dispose();
  }

  Future<void> saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isSaving = true;
    });

    try {
      await context.read<UserProvider>().updateProfile(
        name: nameController.text.trim(),
        careerGoal: careerController.text.trim(),
        productiveHours:
        int.parse(productiveController.text),
        screenTime:
        double.parse(screenTimeController.text),
        bedtime: bedtimeController.text.trim(),
        wakeup: wakeupController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile Updated Successfully"),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }

    setState(() {
      isSaving = false;
    });
  }

  Widget buildField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return "Required";
          }
          return null;
        },
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Edit Profile",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [

              buildField(
                label: "Name",
                controller: nameController,
              ),

              buildField(
                label: "Career Goal",
                controller: careerController,
              ),

              buildField(
                label: "Productive Hours Goal",
                controller: productiveController,
                keyboardType: TextInputType.number,
              ),

              buildField(
                label: "Screen Time Goal",
                controller: screenTimeController,
                keyboardType:
                const TextInputType.numberWithOptions(
                  decimal: true,
                ),
              ),

              buildField(
                label: "Bed Time",
                controller: bedtimeController,
              ),

              buildField(
                label: "Wake Up Time",
                controller: wakeupController,
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed:
                  isSaving ? null : saveProfile,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(18),
                    ),
                  ),
                  child: isSaving
                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                      : const Text(
                    "Save Changes",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}