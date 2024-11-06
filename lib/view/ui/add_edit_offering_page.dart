import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:practitioner_app/model/database_helper.dart';
import 'package:practitioner_app/model/offerings_model.dart';
import 'package:practitioner_app/view_model/offerings_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart'; // Import for SQFlite

class AddEditOfferingPage extends StatefulWidget {
  final Offering? offering;

  AddEditOfferingPage({this.offering});

  @override
  _AddEditOfferingPageState createState() => _AddEditOfferingPageState();
}

class _AddEditOfferingPageState extends State<AddEditOfferingPage> {
  // Declare the form key for FormBuilder
  final _formKey = GlobalKey<FormBuilderState>();

  // Define database helper (SQFlite) instance
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.offering != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Offering' : 'Add Offering'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FormBuilder(
          key: _formKey,
          child: ListView(
            children: [
              _buildPractitionerNameField(),
              _buildTitleField(),
              _buildDescriptionField(),
              _buildServiceCategoryDropdown(),
              _buildServiceTypeDropdown(),
              _buildDurationFields(),
              _buildPriceField(),
              SizedBox(height: 20),
              _buildSubmitButton(isEditing),
            ],
          ),
        ),
      ),
    );
  }

  // Practitioner Name field
  Widget _buildPractitionerNameField() {
    return FormBuilderTextField(
      name: 'practitionerName',
      initialValue: widget.offering?.practitionerName,
      decoration: InputDecoration(labelText: 'Practitioner Name'),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(3),
        FormBuilderValidators.maxLength(50),
      ]),
    );
  }

  // Title field
  Widget _buildTitleField() {
    return FormBuilderTextField(
      name: 'title',
      initialValue: widget.offering?.title,
      decoration: InputDecoration(labelText: 'Title'),
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(3),
        FormBuilderValidators.maxLength(100),
      ]),
    );
  }

  // Description field
  Widget _buildDescriptionField() {
    return FormBuilderTextField(
      name: 'description',
      initialValue: widget.offering?.description,
      decoration: InputDecoration(labelText: 'Description'),
      maxLines: 3,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.minLength(10),
        FormBuilderValidators.maxLength(500),
      ]),
    );
  }

  // Service Category dropdown
  Widget _buildServiceCategoryDropdown() {
    return FormBuilderDropdown<String>(
      name: 'serviceCategory',
      initialValue: widget.offering != null
          ? widget.offering!.category.toString().split('.').last
          : null,
      decoration: InputDecoration(labelText: 'Service Category'),
      items: ServiceCategory.values
          .map((category) => DropdownMenuItem(
                value: category.toString().split('.').last,
                child: Text(category.toString().split('.').last),
              ))
          .toList(),
      validator: FormBuilderValidators.required(),
    );
  }

  // Service Type dropdown
  Widget _buildServiceTypeDropdown() {
    return FormBuilderDropdown<String>(
      name: 'serviceType',
      initialValue: widget.offering != null
          ? widget.offering!.type.toString().split('.').last
          : null,
      decoration: InputDecoration(labelText: 'Service Type'),
      items: ServiceType.values
          .map((type) => DropdownMenuItem(
                value: type.toString().split('.').last,
                child: Text(type.toString().split('.').last),
              ))
          .toList(),
      validator: FormBuilderValidators.required(),
    );
  }

  // Duration fields (Hours and Minutes)
  Widget _buildDurationFields() {
    return Row(
      children: [
        Expanded(
          child: FormBuilderTextField(
            name: 'durationHours',
            initialValue: widget.offering?.duration != null
                ? (widget.offering!.duration.inMinutes ~/ 60).toString()
                : '',
            decoration: InputDecoration(labelText: 'Hours'),
            keyboardType: TextInputType.number,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.numeric(),
              FormBuilderValidators.min(0),
            ]),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: FormBuilderTextField(
            name: 'durationMinutes',
            initialValue: widget.offering?.duration != null
                ? (widget.offering!.duration.inMinutes % 60).toString()
                : '',
            decoration: InputDecoration(labelText: 'Minutes'),
            keyboardType: TextInputType.number,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.numeric(),
              FormBuilderValidators.min(0),
              FormBuilderValidators.max(59),
            ]),
          ),
        ),
      ],
    );
  }

  // Price field
  Widget _buildPriceField() {
    return FormBuilderTextField(
      name: 'price',
      initialValue: widget.offering?.price.toString(),
      decoration: InputDecoration(labelText: 'Price (€)'),
      keyboardType: TextInputType.number,
      validator: FormBuilderValidators.compose([
        FormBuilderValidators.required(),
        FormBuilderValidators.numeric(),
        FormBuilderValidators.min(0),
      ]),
    );
  }

  // Submit button handling (insert or update Offering)
  Widget _buildSubmitButton(bool isEditing) {
    return ElevatedButton(
      onPressed: () async {
        if (_formKey.currentState?.saveAndValidate() ?? false) {
          final values = _formKey.currentState!.value;
          final durationHours =
              int.tryParse(values['durationHours'] ?? '0') ?? 0;
          final durationMinutes =
              int.tryParse(values['durationMinutes'] ?? '0') ?? 0;
          final totalDuration =
              Duration(hours: durationHours, minutes: durationMinutes);

          final offering = Offering(
            id: widget.offering?.id ?? UniqueKey().toString(),
            practitionerName: values['practitionerName'],
            title: values['title'],
            description: values['description'],
            category: ServiceCategory.values.firstWhere(
              (e) => e.toString().split('.').last == values['serviceCategory'],
            ),
            duration: totalDuration,
            type: ServiceType.values.firstWhere(
              (e) => e.toString().split('.').last == values['serviceType'],
            ),
            price: double.parse(values['price']),
          );

          // Using the DatabaseHelper to save the offering
          if (isEditing) {
            await _dbHelper.updateOffering(offering);
          } else {
            await _dbHelper.insertOffering(offering);
          }

          // Close the form and return the offering to the previous page
          Navigator.of(context).pop(offering);
        } else {
          print("Validation failed");
        }
      },
      child: Text(isEditing ? 'Save Changes' : 'Add Offering'),
    );
  }
}
