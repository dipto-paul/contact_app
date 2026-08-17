import 'package:flutter/material.dart';

import '../model/contact.dart';
import '../database/contact_database.dart';


class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});

  @override
  State<AddContactPage> createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {

  // Text Controllers
  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController phoneController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController addressController =
  TextEditingController();


  // Form Key
  final GlobalKey<FormState> formKey =
  GlobalKey<FormState>();


  // Save Contact
  Future<void> saveContact() async {

    // Validate form
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Create Contact Object
    Contact contact = Contact(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      address: addressController.text.trim(),
      isFavorite: false,
    );

    // Insert into database
    await ContactDatabase.insertContact(contact);

    // Show success message
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Contact saved successfully',
        ),
      ),
    );

    // Go back to Home Page
    Navigator.pop(context, true);
  }


  @override
  void dispose() {

    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();

    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      // ------------------------------------------------
      // APP BAR
      // ------------------------------------------------

      appBar: AppBar(

        title: const Text(
          'Add Contact',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),

        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),

        backgroundColor: const Color(0xFF4F46D9),

        elevation: 0,

        actions: [

          IconButton(
            onPressed: saveContact,
            icon: const Icon(
              Icons.check,
              color: Colors.white,
              size: 28,
            ),
          ),

        ],
      ),


      // ------------------------------------------------
      // BODY
      // ------------------------------------------------

      body: SafeArea(

        child: Form(

          key: formKey,

          child: SingleChildScrollView(

            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 25,
            ),

            child: Column(

              children: [

                // ----------------------------------------
                // PROFILE / CAMERA ICON
                // ----------------------------------------

                Container(

                  height: 85,
                  width: 85,

                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFFE8E7FF),
                  ),

                  child: const Icon(
                    Icons.camera_alt,
                    size: 36,
                    color: Color(0xFF4F46D9),
                  ),
                ),

                const SizedBox(height: 35),


                // ----------------------------------------
                // NAME
                // ----------------------------------------

                TextFormField(

                  controller: nameController,

                  textInputAction:
                  TextInputAction.next,

                  decoration: InputDecoration(

                    labelText: 'Name',

                    hintText: 'Enter name',

                    prefixIcon: const Icon(
                      Icons.person_outline,
                    ),

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                    ),

                    enabledBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),

                    focusedBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(
                        color: Color(0xFF4F46D9),
                        width: 2,
                      ),
                    ),
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.trim().isEmpty) {

                      return 'Please enter name';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 14),


                // ----------------------------------------
                // PHONE
                // ----------------------------------------

                TextFormField(

                  controller: phoneController,

                  keyboardType:
                  TextInputType.phone,

                  textInputAction:
                  TextInputAction.next,

                  decoration: InputDecoration(

                    labelText: 'Phone Number',

                    hintText:
                    'Enter phone number',

                    prefixIcon: const Icon(
                      Icons.phone_outlined,
                    ),

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                    ),

                    enabledBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),

                    focusedBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(
                        color: Color(0xFF4F46D9),
                        width: 2,
                      ),
                    ),
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.trim().isEmpty) {

                      return 'Please enter phone number';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 14),


                // ----------------------------------------
                // EMAIL
                // ----------------------------------------

                TextFormField(

                  controller: emailController,

                  keyboardType:
                  TextInputType.emailAddress,

                  textInputAction:
                  TextInputAction.next,

                  decoration: InputDecoration(

                    labelText: 'Email',

                    hintText: 'Enter email',

                    prefixIcon: const Icon(
                      Icons.email_outlined,
                    ),

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                    ),

                    enabledBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),

                    focusedBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(
                        color: Color(0xFF4F46D9),
                        width: 2,
                      ),
                    ),
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.trim().isEmpty) {

                      return 'Please enter email';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 14),


                // ----------------------------------------
                // ADDRESS
                // ----------------------------------------

                TextFormField(

                  controller: addressController,

                  maxLines: 2,

                  textInputAction:
                  TextInputAction.done,

                  decoration: InputDecoration(

                    labelText: 'Address',

                    hintText:
                    'Enter address',

                    prefixIcon: const Icon(
                      Icons.location_on_outlined,
                    ),

                    border: OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                    ),

                    enabledBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                      ),
                    ),

                    focusedBorder:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius.circular(10),
                      borderSide:
                      const BorderSide(
                        color: Color(0xFF4F46D9),
                        width: 2,
                      ),
                    ),
                  ),

                  validator: (value) {

                    if (value == null ||
                        value.trim().isEmpty) {

                      return 'Please enter address';
                    }

                    return null;
                  },
                ),

                const SizedBox(height: 30),


                // ----------------------------------------
                // SAVE BUTTON
                // ----------------------------------------

                SizedBox(

                  width: double.infinity,
                  height: 52,

                  child: ElevatedButton(

                    onPressed: saveContact,

                    style: ElevatedButton.styleFrom(

                      backgroundColor:
                      const Color(0xFF4F46D9),

                      foregroundColor:
                      Colors.white,

                      elevation: 0,

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(10),
                      ),
                    ),

                    child: const Text(

                      'Save Contact',

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}