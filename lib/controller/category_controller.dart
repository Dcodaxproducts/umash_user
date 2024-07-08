import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:umash_user/data/model/response/category_model.dart';
import 'package:umash_user/data/model/response/product_model.dart';
import 'package:umash_user/data/repository/category_repo.dart';

class CategoryController extends GetxController implements GetxService {
  final CategoryRepo categoryRepo;
  CategoryController({required this.categoryRepo});

  static CategoryController get to => Get.find<CategoryController>();

  List<CategoryModel> _categoryList = [];
  List<CategoryModel> _subCategoryList = [];
  List<Product> _categoryProductList = [];
  bool _isLoading = false;
  bool _productLoading = false;
  int _selectedSubCategoryId = -1;
  int _selectCategory = -1;

  List<CategoryModel> get categoryList => _categoryList;
  List<CategoryModel> get subCategoryList => _subCategoryList;
  List<Product> get categoryProductList => _categoryProductList;
  bool get isLoading => _isLoading;
  bool get productLoading => _productLoading;
  int get selectedSubCategoryId => _selectedSubCategoryId;
  int get selectCategory => _selectCategory;

  set isLoading(bool value) {
    _isLoading = value;
    update();
  }

  set productLoading(bool value) {
    _productLoading = value;
    update();
  }

  set selectCategory(int value) {
    _selectCategory = value;
    update();
  }

  Future<void> getCategoryList({bool theme1 = false}) async {
    _subCategoryList = [];
    isLoading = true;
    http.Response? response = await categoryRepo.getCategoryList();
    if (response != null) {
      _categoryList = [];
      List<dynamic> data = jsonDecode(response.body);
      for (var category in data) {
        _categoryList.add(CategoryModel.fromJson(category));
      }
      if (theme1) {
        _productLoading = true;
        _categoryProductList = [];
        _productLoading = false;
      }
    }
    isLoading = false;
  }

  Future<void> getCategoryProductList(String? categoryID,
      {String type = 'all'}) async {
    _categoryProductList = [];
    _selectedSubCategoryId = -1;
    update();

    http.Response? response =
        await categoryRepo.getCategoryProductList(categoryID, type);
    if (response != null) {
      List<dynamic> data = jsonDecode(response.body);
      for (var item in data) {
        _categoryProductList.add(Product.fromJson(item));
      }
    }
    isLoading = false;
  }
}
