import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:medease1/generated/l10n.dart';

class BuildCountryDropdown extends StatefulWidget {
  const BuildCountryDropdown({
    super.key,
    required Null Function(dynamic country) onCountrySelected,
  });

  @override
  State<BuildCountryDropdown> createState() => _BuildCountryDropdownState();
}

Country? selectedCountry;

class _BuildCountryDropdownState extends State<BuildCountryDropdown> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: GestureDetector(
        onTap: () {
          showCountryPicker(
            context: context,
            showPhoneCode: false,
            onSelect:
                (Country country) => setState(() => selectedCountry = country),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                selectedCountry?.name ?? S.of(context).selectCountry,
                style: TextStyle(fontSize: 16),
              ),
              Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
