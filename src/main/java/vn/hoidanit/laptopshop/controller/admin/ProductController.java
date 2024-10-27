package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UploadService;

@Controller
public class ProductController {
    private final ProductService productService;
    private final UploadService uploadService;

    public ProductController(ProductService productService, UploadService uploadService) {
        this.productService = productService;
        this.uploadService = uploadService;
    }

    @GetMapping("/admin/product")
    public String getProductPage(Model model) {
        List<Product> products = this.productService.getAllProducts();
        model.addAttribute("products", products);
        return "admin/product/show";
    }

    @GetMapping("/admin/product/create")
    public String getCreateProductPage(@ModelAttribute("newProduct") Product newProduct) {
        return "admin/product/create";
    }

    @PostMapping("/admin/product/create")
    public String createProduct(
            @ModelAttribute("newProduct") @Valid Product newProduct,
            BindingResult newProductBindingResult,
            @RequestParam("uploadFile") MultipartFile file) {

        if (newProductBindingResult.hasErrors()) {
            return "admin/product/create";
        }

        String image = this.uploadService.handleSaveUploadFile(file, "product");
        newProduct.setImage(image);

        this.productService.createProduct(newProduct);
        return "redirect:/admin/product";
    }

    @GetMapping("/admin/product/{id}")
    public String getProductDetail(
            Model model,
            @PathVariable long id) {
        Product product = this.productService.getProductById(id).get();
        model.addAttribute("product", product);
        return "admin/product/detail";
    }

    @GetMapping("/admin/product/update/{id}")
    public String getProductUpdate(
            Model model,
            @PathVariable long id) {
        Product product = this.productService.getProductById(id).get();
        model.addAttribute("product", product);
        return "admin/product/update";
    }

    @PostMapping("/admin/product/update/{id}")
    public String postMethodName(
            @ModelAttribute("product") Product product,
            BindingResult updateProductBindingResult,
            @RequestParam("uploadFile") MultipartFile file,
            @PathVariable long id) {
        if (updateProductBindingResult.hasErrors()) {
            return "admin/product/update";
        }

        Product currentProduct = this.productService.getProductById(id).get();
        if (currentProduct != null) {
            currentProduct.setName(product.getName());
            currentProduct.setPrice(product.getPrice());
            currentProduct.setDetailDesc(product.getDetailDesc());
            currentProduct.setShortDesc(product.getShortDesc());
            currentProduct.setQuantity(product.getQuantity());
            currentProduct.setFactory(product.getFactory());
            currentProduct.setTarget(product.getTarget());

            if (!file.isEmpty()) {
                String image = this.uploadService.handleSaveUploadFile(file, "product");
                currentProduct.setImage(image);
            }
        }
        this.productService.createProduct(currentProduct);
        return "redirect:/admin/product";

    }

    @GetMapping("/admin/product/delete/{id}")
    public String getDeleteProduct(
            Model model,
            @ModelAttribute("product") Product product,
            @PathVariable long id) {

        model.addAttribute("id", id);
        return "admin/product/delete";
    }

    @PostMapping("/admin/product/delete/{id}")
    public String postDeleteProduct(
            @ModelAttribute("product") Product product,
            @PathVariable long id) {
        this.productService.deleteProductById(id);
        return "redirect:/admin/product";
    }

}
