import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:niklaar/core/constants/constants.dart';
import 'package:niklaar/core/theme/app_colors.dart';
import 'package:niklaar/shared/widgets/app_padding.dart';
import 'package:country_picker/country_picker.dart';
import 'package:niklaar/shared/widgets/custom_header.dart';
import 'package:niklaar/shared/widgets/custom_text.dart';
import 'package:niklaar/shared/widgets/textfields/custom_field.dart';
import 'package:niklaar/shared/widgets/buttons/roundedbutton.dart';

@RoutePage(name: 'SelectCountryRoute')
class SelectCountry extends StatefulWidget {
  const SelectCountry({super.key});

  @override
  State<SelectCountry> createState() => _SelectCountryState();
}

class _SelectCountryState extends State<SelectCountry> {
  late List<Country> _allCountries;
  late List<Country> _filteredCountries;
  final TextEditingController _searchController = TextEditingController();
  final Map<String, List<Country>> _groupedCountries = {};
  final List<String> _alphabet = [];
  Country? _selectedCountry;

  @override
  void initState() {
    super.initState();
    _initializeCountries();
    _searchController.addListener(_filterCountries);
  }

  void _initializeCountries() {
    _allCountries = CountryService().getAll();
    _filteredCountries = List.from(_allCountries);

    for (var country in _allCountries) {
      final firstLetter = country.name[0].toUpperCase();
      if (!_groupedCountries.containsKey(firstLetter)) {
        _groupedCountries[firstLetter] = [];
        _alphabet.add(firstLetter);
      }
      _groupedCountries[firstLetter]!.add(country);
    }

    _alphabet.sort();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterCountries() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCountries = List.from(_allCountries);
      } else {
        _filteredCountries =
            _allCountries
                .where((country) => country.name.toLowerCase().contains(query))
                .toList();
      }
    });
  }

  void _selectCountry(Country country) {
    setState(() {
      _selectedCountry = country;
      _searchController.text = "${country.flagEmoji} ${country.name}";
    });
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildSearchField(),
              const SizedBox(height: 16),
              if (_selectedCountry == null)
                Expanded(child: _buildCountriesList()),
              if (_selectedCountry != null)
                Padding(
                  padding: EdgeInsets.only(top: height * 0.55),
                  child: CustomButton(
                    title: "Continue",
                    onTap: () {
                      context.router.pushNamed('/sign-up');
                    },
                    color: AppColor.primary,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return CustomAuthHeader(context: context);
  }

  Widget _buildSearchField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 30,
      children: [
        NikText(text: 'Select your country', size: 20, weight: FontWeight.w500),

        TextInputField(
          hintText: 'Search Country',
          controller: _searchController,
          suffixIcon: const Icon(Icons.search, color: AppColor.secondary),
          borderColor: AppColor.nikGrey,
          onTap:
              _selectedCountry == null
                  ? null
                  : () {
                    setState(() {
                      _selectedCountry = null;
                      _searchController.clear();
                    });
                  },
          isReadOnly: _selectedCountry != null,
        ),
      ],
    );
  }

  Widget _buildCountriesList() {
    return ListView.builder(
      itemCount: _filteredCountries.length,
      itemBuilder: (context, index) {
        final country = _filteredCountries[index];

        final String firstLetter = country.name[0].toUpperCase();

        bool showIndexLetter =
            index == 0 ||
            _filteredCountries[index - 1].name[0].toUpperCase() != firstLetter;

        return Column(
          children: [
            if (showIndexLetter)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: NikText(
                    text: firstLetter,
                    size: 18,
                    weight: FontWeight.bold,
                    color: Colors.grey[400],
                  ),
                ),
              ),
            ListTile(
              leading: SizedBox(
                width: 40,
                height: 30,
                child: NikText(text: country.flagEmoji, size: 20),
              ),
              title: NikText(
                text: country.name,
                size: 16,
                weight: FontWeight.w500,
                align: TextAlign.left,
              ),
              onTap: () => _selectCountry(country),
            ),
            Divider(height: 1, color: Colors.grey[300]),
          ],
        );
      },
    );
  }
}
