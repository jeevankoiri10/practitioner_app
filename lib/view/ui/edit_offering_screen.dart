import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:practitioner_app/model/offerings_model.dart';
import 'package:practitioner_app/offerings_provider.dart';
import 'package:provider/provider.dart';

class AddEditOfferingScreen extends StatefulWidget {
  final Offering? offering;

  AddEditOfferingScreen({this.offering});

  @override
  _AddEditOfferingScreenState createState() => _AddEditOfferingScreenState();
}

class _AddEditOfferingScreenState extends State<AddEditOfferingScreen> {
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
              FormBuilderTextField(
                name: 'practitionerName',
                initialValue: widget.offering?.practitionerName,
                decoration: InputDecoration(labelText: 'Practitioner Name'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(3),
                  FormBuilderValidators.maxLength(50),
                ]),
              ),
              FormBuilderTextField(
                name: 'title',
                initialValue: widget.offering?.title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(3),
                  FormBuilderValidators.maxLength(100),
                ]),
              ),
              FormBuilderTextField(
                name: 'description',
                initialValue: widget.offering?.description,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.minLength(10),
                  FormBuilderValidators.maxLength(500),
                ]),
              ),
              FormBuilderDropdown<String>(
                name: 'category',
                initialValue: widget.offering?.category,
                decoration: InputDecoration(labelText: 'Category'),
                items: ['Spiritual', 'Mental', 'Emotional', 'Physical']
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category),
                        ))
                    .toList(),
                validator: FormBuilderValidators.required(),
              ),
              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'durationHours',
                      initialValue: widget.offering?.duration != null
                          ? widget.offering!.duration.split(' ').first
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
                          ? widget.offering!.duration
                              .split(' ')
                              .firstWhere((element) => element.endsWith('min'))
                              .replaceAll('min', '')
                              .trim()
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
              ),
              FormBuilderRadioGroup<String>(
                name: 'type',
                initialValue: widget.offering?.type,
                decoration: InputDecoration(labelText: 'Type'),
                options: [
                  FormBuilderFieldOption(
                      value: 'In-Person', child: Text('In-Person')),
                  FormBuilderFieldOption(
                      value: 'Online', child: Text('Online')),
                ],
                validator: FormBuilderValidators.required(),
              ),
              FormBuilderTextField(
                name: 'price',
                initialValue: widget.offering?.price.toString(),
                decoration: InputDecoration(labelText: 'Price (€)'),
                keyboardType: TextInputType.number,
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.min(0),
                ]),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.saveAndValidate() ?? false) {
                    final values = _formKey.currentState!.value;
                    final durationHours =
                        int.tryParse(values['durationHours'] ?? '0') ?? 0;
                    final durationMinutes =
                        int.tryParse(values['durationMinutes'] ?? '0') ?? 0;
                    final totalDuration = Duration(
                        hours: durationHours, minutes: durationMinutes);

                    final offering = Offering(
                      id: widget.offering?.id ?? UniqueKey().toString(),
                      practitionerName: values['practitionerName'],
                      title: values['title'],
                      description: values['description'],
                      category: values['category'],
                      duration:
                          '${totalDuration.inMinutes} min', // Store as string
                      type: values['type'],
                      price: double.parse(values['price']),
                    );
                    if (isEditing) {
                      offeringsProvider.updateOffering(offering.id, offering);
                    } else {
                      offeringsProvider.addOffering(offering);
                    }
                    Navigator.of(context).pop();
                  } else {
                    print("Validation failed");
                  }
                },
                child: Text(isEditing ? 'Save Changes' : 'Add Offering'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
