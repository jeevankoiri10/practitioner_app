import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:practitioner_app/model/offerings_model.dart';
import 'package:practitioner_app/view_model/offerings_provider.dart';
import 'package:provider/provider.dart';

class AddEditOfferingPage extends StatefulWidget {
  final Offering? offering;

  AddEditOfferingPage({this.offering});

  @override
  _AddEditOfferingPageState createState() => _AddEditOfferingPageState();
}

class _AddEditOfferingPageState extends State<AddEditOfferingPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.offering != null;
    final offeringsProvider =
        Provider.of<OfferingsProvider>(context, listen: false);

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
              _buildSubmitButton(offeringsProvider, isEditing),
            ],
          ),
        ),
      ),
    );
  }

  // Add Practitioner Name Field
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

  // Add Title Field
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

  // Add Description Field
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

  // Add Service Category Dropdown
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

  // Add Service Type Dropdown
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

  // Add Duration Fields
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

  // Add Price Field
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

  // Add Submit Button
  Widget _buildSubmitButton(
      OfferingsProvider offeringsProvider, bool isEditing) {
    return ElevatedButton(
      onPressed: () {
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
            duration: totalDuration, // Store as Duration object
            type: ServiceType.values.firstWhere(
              (e) => e.toString().split('.').last == values['serviceType'],
            ),
            price: double.parse(values['price']),
          );
          if (isEditing) {
            offeringsProvider.updateOffering(offering.id, offering);
          } else {
            offeringsProvider.addOffering(offering);
          }
          setState(() {
            Navigator.of(context).pop(offering);
          });
        } else {
          print("Validation failed");
        }
      },
      child: Text(isEditing ? 'Save Changes' : 'Add Offering'),
    );
  }
}
