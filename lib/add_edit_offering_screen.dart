import 'package:flutter/material.dart';
import 'package:practitioner_app/offerings_model.dart';
import 'package:provider/provider.dart';
import 'offerings_provider.dart';

class AddEditOfferingScreen extends StatefulWidget {
  final Offering? offering;

  AddEditOfferingScreen({this.offering});

  @override
  _AddEditOfferingScreenState createState() => _AddEditOfferingScreenState();
}

class _AddEditOfferingScreenState extends State<AddEditOfferingScreen> {
  final _formKey = GlobalKey<FormState>();
  late String practitionerName, title, description, category, duration, type;
  late double price;

  @override
  void initState() {
    super.initState();
    if (widget.offering != null) {
      practitionerName = widget.offering!.practitionerName;
      title = widget.offering!.title;
      description = widget.offering!.description;
      category = widget.offering!.category;
      duration = widget.offering!.duration;
      type = widget.offering!.type;
      price = widget.offering!.price;
    } else {
      practitionerName = '';
      title = '';
      description = '';
      category = 'Spiritual';
      duration = '30 min';
      type = 'In-Person';
      price = 0.0;
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final newOffering = Offering(
        id: widget.offering?.id ?? UniqueKey().toString(),
        practitionerName: practitionerName,
        title: title,
        description: description,
        category: category,
        duration: duration,
        type: type,
        price: price,
      );

      final provider = Provider.of<OfferingsProvider>(context, listen: false);
      if (widget.offering != null) {
        provider.updateOffering(widget.offering!.id, newOffering);
      } else {
        provider.addOffering(newOffering);
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.offering != null ? 'Edit Offering' : 'Add Offering'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: practitionerName,
                decoration: InputDecoration(labelText: 'Practitioner Name'),
                onSaved: (value) => practitionerName = value!,
              ),
              TextFormField(
                initialValue: title,
                decoration: InputDecoration(labelText: 'Title'),
                onSaved: (value) => title = value!,
              ),
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => description = value!,
              ),
              DropdownButtonFormField<String>(
                value: category,
                decoration: InputDecoration(labelText: 'Category'),
                items:
                    ['Spiritual', 'Mental', 'Emotional'].map((String category) {
                  return DropdownMenuItem<String>(
                    value: category,
                    child: Text(category),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    category = value!;
                  });
                },
              ),
              TextFormField(
                initialValue: duration,
                decoration: InputDecoration(labelText: 'Duration'),
                onSaved: (value) => duration = value!,
              ),
              Row(
                children: [
                  Text('In-Person'),
                  Radio(
                    value: 'In-Person',
                    groupValue: type,
                    onChanged: (value) {
                      setState(() {
                        type = value!;
                      });
                    },
                  ),
                  Text('Online'),
                  Radio(
                    value: 'Online',
                    groupValue: type,
                    onChanged: (value) {
                      setState(() {
                        type = value!;
                      });
                    },
                  ),
                ],
              ),
              TextFormField(
                initialValue: price.toString(),
                decoration: InputDecoration(labelText: 'Price (€)'),
                keyboardType: TextInputType.number,
                onSaved: (value) => price = double.parse(value!),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
