import 'package:flutter/material.dart';

import '../database/contact_database.dart';
import '../model/contact.dart';

class EditContactPage extends StatefulWidget {
  final Contact contact;

  const EditContactPage({
    super.key,
    required this.contact,
  });

  @override
  State<EditContactPage> createState() =>
      _EditContactPageState();
}

class _EditContactPageState
    extends State<EditContactPage> {

  // --------------------------------------------------
  // CONTROLLERS
  // --------------------------------------------------

  final TextEditingController nameController =
  TextEditingController();

  final TextEditingController phoneController =
  TextEditingController();

  final TextEditingController emailController =
  TextEditingController();

  final TextEditingController addressController =
  TextEditingController();


  // --------------------------------------------------
  // FORM KEY
  // --------------------------------------------------

  final GlobalKey<FormState> formKey =
  GlobalKey<FormState>();


  // --------------------------------------------------
  // INIT STATE
  // --------------------------------------------------

  @override
  void initState() {
    super.initState();

    // Existing contact data
    nameController.text =
        widget.contact.name;

    phoneController.text =
        widget.contact.phone;

    emailController.text =
        widget.contact.email;

    addressController.text =
        widget.contact.address;
  }


  // --------------------------------------------------
  // UPDATE CONTACT
  // --------------------------------------------------

  Future<void> updateContact() async {

    // Validate form
    if (!formKey.currentState!.validate()) {
      return;
    }

    // Create updated contact object
    Contact updatedContact = Contact(

      id: widget.contact.id,

      name: nameController.text.trim(),

      phone: phoneController.text.trim(),

      email: emailController.text.trim(),

      address: addressController.text.trim(),

      isFavorite: widget.contact.isFavorite,
    );


    // Update database
    await ContactDatabase.updateContact(
      updatedContact,
    );


    if (!mounted) return;


    // Success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Contact updated successfully',
        ),
      ),
    );


    // Return to previous page
    Navigator.pop(context, true);
  }


  // --------------------------------------------------
  // TEXT FIELD
  // --------------------------------------------------

  Widget contactField({

    required TextEditingController controller,

    required String label,

    required String hint,

    required IconData icon,

    TextInputType keyboardType =
        TextInputType.text,

    TextInputAction textInputAction =
        TextInputAction.next,

    int maxLines = 1,

  }) {

    return TextFormField(

      controller: controller,

      keyboardType: keyboardType,

      textInputAction: textInputAction,

      maxLines: maxLines,

      style: const TextStyle(
        fontSize: 13,
        color: Colors.black87,
      ),

      decoration: InputDecoration(

        labelText: label,

        hintText: hint,

        labelStyle: TextStyle(
          fontSize: 11,
          color: Colors.grey.shade600,
        ),

        hintStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey.shade500,
        ),

        border: OutlineInputBorder(

          borderRadius:
          BorderRadius.circular(10),

          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
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
            color: Color(0xFF5146D8),
            width: 1.5,
          ),
        ),

        prefixIcon: Icon(
          icon,
          size: 19,
          color: Colors.grey.shade600,
        ),

        contentPadding:
        const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 13,
        ),
      ),

      validator: (value) {

        if (value == null ||
            value.trim().isEmpty) {

          return 'Please enter $label';
        }

        return null;
      },
    );
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(



      appBar: AppBar(

        backgroundColor:
        const Color(0xFF5146D8),

        foregroundColor:
        Colors.white,

        elevation: 0,

        toolbarHeight: 62,


        // Back button
        leading: IconButton(

          onPressed: () {

            Navigator.pop(context);
          },

          icon: const Icon(
            Icons.arrow_back,
            size: 22,
          ),
        ),


        // Title
        title: const Text(

          'Edit Contact',

          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),


        // Update check button
        actions: [

          IconButton(

            onPressed: updateContact,

            icon: const Icon(
              Icons.check,
              size: 25,
            ),
          ),
        ],
      ),



      body: SafeArea(

        child: Form(

          key: formKey,

          child: SingleChildScrollView(

            padding:
            const EdgeInsets.fromLTRB(
              14,
              27,
              14,
              30,
            ),

            child: Column(

              children: [


                Container(

                  height: 70,

                  width: 70,

                  decoration:
                  const BoxDecoration(

                    shape: BoxShape.circle,

                    color: Color(0xFFE9E8FF),
                  ),

                  child: const Icon(

                    Icons.camera_alt,

                    size: 31,

                    color: Color(0xFF5146D8),
                  ),
                ),


                const SizedBox(height: 28),



                contactField(

                  controller:
                  nameController,

                  label: 'Name',

                  hint: 'Name',

                  icon:
                  Icons.person_outline,

                  textInputAction:
                  TextInputAction.next,
                ),


                const SizedBox(height: 10),


                contactField(

                  controller:
                  phoneController,

                  label: 'Phone Number',

                  hint: 'Phone Number',

                  icon:
                  Icons.phone_outlined,

                  keyboardType:
                  TextInputType.phone,

                  textInputAction:
                  TextInputAction.next,
                ),


                const SizedBox(height: 10),



                contactField(

                  controller:
                  emailController,

                  label: 'Email',

                  hint: 'Email',

                  icon:
                  Icons.email_outlined,

                  keyboardType:
                  TextInputType.emailAddress,

                  textInputAction:
                  TextInputAction.next,
                ),


                const SizedBox(height: 10),



                contactField(

                  controller:
                  addressController,

                  label: 'Address',

                  hint: 'Address',

                  icon:
                  Icons.location_on_outlined,

                  textInputAction:
                  TextInputAction.done,

                  maxLines: 2,
                ),


                const SizedBox(height: 28),



                SizedBox(

                  width: double.infinity,

                  height: 48,

                  child: ElevatedButton(

                    onPressed:
                    updateContact,

                    style:
                    ElevatedButton.styleFrom(

                      backgroundColor:
                      const Color(0xFF5146D8),

                      foregroundColor:
                      Colors.white,

                      elevation: 0,

                      shape:
                      RoundedRectangleBorder(

                        borderRadius:
                        BorderRadius.circular(8),
                      ),
                    ),

                    child: const Text(

                      'Update Contact',

                      style: TextStyle(
                        fontSize: 13,
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




  @override
  void dispose() {

    nameController.dispose();

    phoneController.dispose();

    emailController.dispose();

    addressController.dispose();

    super.dispose();
  }
}