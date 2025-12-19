import 'package:eux_client/common/constants/egypt_locations.dart';
import 'package:eux_client/common/widgets/app_button.dart';
import 'package:eux_client/common/widgets/custom_textfeild.dart';
import 'package:eux_client/features/home/data/order_model.dart';
import 'package:eux_client/features/home/presentation/cubit/order_cubit.dart';
import 'package:eux_client/features/home/presentation/cubit/order_state.dart';
import 'package:eux_client/resources/app_values.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddEditOrder extends StatefulWidget {
  final OrderModel? existingOrder;

  const AddEditOrder({super.key, this.existingOrder});

  @override
  State<AddEditOrder> createState() => _AddEditOrderState();
}

class _AddEditOrderState extends State<AddEditOrder> {
  // Text Controllers
  final _orderCodeController = TextEditingController();
  final _customerNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _phone2Controller = TextEditingController();
  final _areaController = TextEditingController();
  final _streetController = TextEditingController();
  final _weightController = TextEditingController();
  final _amountController = TextEditingController();
  final _itemTypeController = TextEditingController();
  final _itemNameController = TextEditingController();
  final _currencyController = TextEditingController();

  // Dropdown values
  String? _selectedExpressProduct;
  String? _selectedGovernorate;
  String? _selectedCity;

  // Available cities based on selected governorate
  List<String> _availableCities = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingOrder != null) {
      _fillFormWithExistingData();
    }
  }

  void _fillFormWithExistingData() {
    final order = widget.existingOrder!;
    _orderCodeController.text = order.orderCode ?? '';
    _customerNameController.text = order.receiver ?? '';
    _phoneController.text = order.receiverPhoneNumber ?? '';
    _phone2Controller.text = order.receiverPhoneNumber2 ?? '';
    _areaController.text = order.arrivalArea ?? '';
    _streetController.text = order.receiverStreet ?? '';
    _weightController.text = order.goodsWeight ?? '';
    _amountController.text = order.codAmount ?? '';
    _itemTypeController.text = order.itemType ?? '';
    _itemNameController.text = order.itemName ?? '';
    _currencyController.text = order.codCurrency ?? 'Egypt';

    // Set dropdown values
    _selectedExpressProduct = order.expressProduct;
    _selectedGovernorate = order.arrivalGovernorate;

    // Load cities for the selected governorate
    if (_selectedGovernorate != null) {
      _availableCities = EgyptLocations.getCitiesForGovernorate(
        _selectedGovernorate!,
      );
      _selectedCity = order.arrivalCity;
    }
  }

  // String _generateOrderCode() {
  //   return 'ORD${DateTime.now().millisecondsSinceEpoch}';
  // }

  void _onGovernorateChanged(String? newValue) {
    setState(() {
      _selectedGovernorate = newValue;
      _selectedCity = null; // Reset city when governorate changes
      _availableCities = newValue != null
          ? EgyptLocations.getCitiesForGovernorate(newValue)
          : [];
    });
  }

  bool _validateForm() {
    if (_customerNameController.text.trim().isEmpty) {
      _showError('الرجاء إدخال اسم العميل');
      return false;
    }
    if (_phoneController.text.trim().isEmpty) {
      _showError('الرجاء إدخال رقم الهاتف');
      return false;
    }
    if (_selectedGovernorate == null) {
      _showError('الرجاء اختيار المحافظة');
      return false;
    }
    if (_selectedCity == null) {
      _showError('الرجاء اختيار المدينة');
      return false;
    }
    if (_areaController.text.trim().isEmpty) {
      _showError('الرجاء إدخال المنطقة');
      return false;
    }
    if (_amountController.text.trim().isEmpty) {
      _showError('الرجاء إدخال المبلغ المراد تحصيله ');
      return false;
    }
    if (_weightController.text.trim().isEmpty) {
      _showError('الرجاء إدخال الوزن ');
      return false;
    }
    if (_selectedExpressProduct == null) {
      _showError('الرجاء إدخال المنطقة');
      return false;
    }
    return true;
  }

  void _showError(String message) {
    print(message);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showSuccess(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  Future<void> _saveOrder() async {
    if (!_validateForm()) return;

    setState(() => _isLoading = true);

    try {
      final order = OrderModel(
        orderCode: _orderCodeController.text.trim(),
        receiver: _customerNameController.text.trim(),
        receiverPhoneNumber: _phoneController.text.trim(),
        receiverPhoneNumber2: _phone2Controller.text.trim(),
        arrivalGovernorate: _selectedGovernorate,
        arrivalCity: _selectedCity,
        arrivalArea: _areaController.text.trim(),
        receiverStreet: _streetController.text.trim(),
        goodsWeight: _weightController.text.trim(),
        codAmount: _amountController.text.trim(),
        codCurrency: 'Egypt',
        expressProduct: _selectedExpressProduct,
        itemType: _itemTypeController.text.trim(),
        itemName: _itemNameController.text.trim(),
        rc: "01500060828",
      );

      // ✅ استخدم الـ Cubit بدل الـ Service
      if (widget.existingOrder != null) {
        await context.read<OrdersCubit>().editOrder(
          widget.existingOrder!.receiverPhoneNumber!,
          order,
        );
        _showSuccess('تم تحديث الطلب بنجاح');
      } else {
        await context.read<OrdersCubit>().addOrder(order);
        _showSuccess('تم إضافة الطلب بنجاح');
      }

      await Future.delayed(const Duration(milliseconds: 500));

      if (mounted) {
        Navigator.pop(context);
      }
    } catch (e) {
      _showError('خطأ: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.existingOrder != null;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(isEditMode ? 'Edit Order' : 'Add Order'),
      ),
      body: BlocListener<OrdersCubit, OrdersState>(
        listener: (context, state) {
          if (state is OrdersError) {
            _showError(state.message);
            setState(() => _isLoading = false);
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: AppPadding.p20,
            horizontal: AppPadding.p16,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSize.s14),

                // // Order Code (read-only)
                // const Text('Order Code'),
                // CustomTextField(
                //   hintText: 'Order Code',
                //   controller: _orderCodeController,
                // ),
                // const SizedBox(height: AppSize.s10),

                // Customer Name
                const Text('Customer Name *'),
                CustomTextField(
                  hintText: 'Customer Name',
                  controller: _customerNameController,
                ),
                const SizedBox(height: AppSize.s10),

                // Phone Number
                const Text('Receiver\'s Phone Number *'),
                CustomTextField(
                  hintText: 'Receiver\'s phonenumber',
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: AppSize.s10),

                // Second Phone Number
                const Text('Another Receiver\'s Phone Number'),
                CustomTextField(
                  hintText: 'Another Receiver\'s phonenumber',
                  controller: _phone2Controller,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: AppSize.s10),

                // Governorate Dropdown
                const Text('Arrival Governorate *'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedGovernorate,
                      hint: const Text('اختر المحافظة'),
                      isExpanded: true,
                      items: EgyptLocations.governorates.map((
                        String governorate,
                      ) {
                        return DropdownMenuItem<String>(
                          value: governorate,
                          child: Text(governorate),
                        );
                      }).toList(),
                      onChanged: _onGovernorateChanged,
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s10),

                // City Dropdown (dependent on Governorate)
                const Text('Arrival City *'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedCity,
                      hint: Text(
                        _selectedGovernorate == null
                            ? 'اختر المحافظة أولاً'
                            : 'اختر المدينة',
                      ),
                      isExpanded: true,
                      items: _availableCities.map((String city) {
                        return DropdownMenuItem<String>(
                          value: city,
                          child: Text(city),
                        );
                      }).toList(),
                      onChanged: _selectedGovernorate == null
                          ? null
                          : (String? newValue) {
                              setState(() {
                                _selectedCity = newValue;
                              });
                            },
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s10),

                // Area
                const Text('Arrival Area *'),
                CustomTextField(
                  hintText: 'Arrival area',
                  controller: _areaController,
                ),
                const SizedBox(height: AppSize.s10),

                // Street
                const Text('Receiver Street'),
                CustomTextField(
                  hintText: 'Receiver street',
                  controller: _streetController,
                ),
                const SizedBox(height: AppSize.s10),

                // Weight
                const Text('Goods Weight'),
                CustomTextField(
                  hintText: 'Goods weight',
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: AppSize.s10),

                // Amount
                const Text('COD Amount'),
                CustomTextField(
                  hintText: 'Total Amount',
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: AppSize.s10),

                // Express Product Dropdown
                const Text('Express Product'),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedExpressProduct,
                      hint: const Text('Select Express Product'),
                      isExpanded: true,
                      items: EgyptLocations.expressProducts.map((
                        String product,
                      ) {
                        return DropdownMenuItem<String>(
                          value: product,
                          child: Text(product),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedExpressProduct = newValue;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: AppSize.s10),

                // Submit Button
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : CustomAppButton(
                        onPressed: _saveOrder,
                        title: isEditMode ? 'Update Order' : 'Add Order',
                      ),
                const SizedBox(height: AppSize.s40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _orderCodeController.dispose();
    _customerNameController.dispose();
    _phoneController.dispose();
    _phone2Controller.dispose();
    _areaController.dispose();
    _streetController.dispose();
    _weightController.dispose();
    _amountController.dispose();
    _itemTypeController.dispose();
    _itemNameController.dispose();
    _currencyController.dispose();
    super.dispose();
  }
}
