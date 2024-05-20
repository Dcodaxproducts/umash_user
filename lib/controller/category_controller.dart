import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:umash_user/data/model/response/category_model.dart';
import 'package:umash_user/data/model/response/product_model.dart';
import 'package:umash_user/data/repository/category_repo.dart';
import 'package:umash_user/utils/images.dart';

class CategoryController extends GetxController implements GetxService {
  final CategoryRepo categoryRepo;
  CategoryController({required this.categoryRepo});

  static CategoryController get to => Get.find<CategoryController>();

  List<CategoryModel> _categoryList = [];
  List<CategoryModel> _subCategoryList = [];
  List<Product> _categoryProductList = [];
  List<Product> _filteredList = [];
  bool _isLoading = false;
  bool _productLoading = false;
  int _selectedSubCategoryId = -1;
  int _selectCategory = -1;

  List<CategoryModel> get categoryList => _categoryList;
  List<CategoryModel> get subCategoryList => _subCategoryList;
  List<Product> get categoryProductList => _categoryProductList;
  List<Product> get filteredList => _filteredList;
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

  set selectedSubCategoryId(int value) {
    _selectedSubCategoryId = value;
    if (value == -1) {
      _filteredList = _categoryProductList;
    } else {
      _filteredList = _categoryProductList
          .where((product) =>
              product.categoryIds!.any((cat) => cat.id == value.toString()))
          .toList();
    }
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
        _filteredList = [];
        for (var e in _categoryList) {
          getCategoryProductList(e.id.toString(), theme1: true);
        }
        // await Future.wait(_categoryList
        //     .map((e) => getCategoryProductList(e.id.toString(), theme1: true))
        //     .toList());
        _productLoading = false;
      }
    }
    isLoading = false;
  }

  void getSubCategoryList(String categoryID) async {
    _subCategoryList = [];
    _selectCategory =
        _categoryList.indexWhere((e) => e.id == int.parse(categoryID));
    isLoading = true;
    getCategoryProductList(categoryID);
    http.Response? response = await categoryRepo.getSubCategoryList(categoryID);
    if (response != null) {
      _subCategoryList = [];
      List<dynamic> data = jsonDecode(response.body);
      _subCategoryList.add(CategoryModel(
        id: -1,
        name: 'All',
        image: Images.categoryPlaceHolder,
      ));
      for (var category in data) {
        _subCategoryList.add(CategoryModel.fromJson(category));
      }
      update();
    }
  }

  Future<void> getCategoryProductList(String? categoryID,
      {String type = 'all', bool theme1 = false}) async {
    if (!theme1) {
      _categoryProductList = [];
      _filteredList = [];
      _selectedSubCategoryId = -1;
      update();
    }

    http.Response? response =
        await categoryRepo.getCategoryProductList(categoryID, type);
    if (response != null) {
      List<dynamic> data = jsonDecode(response.body);
      for (var item in data) {
        _categoryProductList.add(Product.fromJson(item));
      }
      if (!theme1) {
        _filteredList = _categoryProductList;
      } else {
        filterListByCategoryID(_categoryList[0].id.toString());
      }
    }
    isLoading = false;
  }

  filterListByCategoryID(String categoryID) {
    _filteredList = _categoryProductList
        .where((product) =>
            product.categoryIds!.any((cat) => cat.id == categoryID))
        .toList();
    update();
  }
}
