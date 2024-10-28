package vn.hoidanit.laptopshop.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UserService;

import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class ItemController {

    private final ProductService productService;
    private final UserService userService;

    public ItemController(ProductService productService, UserService userService) {
        this.productService = productService;
        this.userService = userService;
    }

    @GetMapping("/product/{id}")
    public String getProductDetailPage(Model model, @PathVariable long id) {
        Product product = this.productService.getProductById(id).get();
        model.addAttribute("product", product);
        return "client/product/detail";
    }

    @PostMapping("/add-product-to-cart/{id}")
    public String postAddProductToCart(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);

        long productId = id;
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, productId, session);
        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long user_id = (long) session.getAttribute("id");
        User user = this.userService.getUserById(user_id);

        // check if cart is empty
        List<CartDetail> cartDetails = user.getCart() == null ? new ArrayList<CartDetail>()
                : user.getCart().getCartDetails();
        model.addAttribute("cartDetails", cartDetails);
        return "client/cart/show";
    }

    @PostMapping("/delete-cart-product/{id}")
    public String postMethodName(@PathVariable long id, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long user_id = (long) session.getAttribute("id");
        User user = this.userService.getUserById(user_id);
        Cart cart = this.productService.getCartByUser(user);

        this.productService.deleteCartDetailById(id);
        if (cart.getSum() > 1) {
            cart.setSum(cart.getSum() - 1);
            int sum = cart.getSum();
            session.setAttribute("sum", sum);
            this.productService.handleSaveCart(cart);
            return "redirect:/cart";
        }

        if (cart.getSum() == 1) {
            this.productService.deleteCartById(cart.getId());
            session.setAttribute("sum", 0);
        }
        return "client/cart/show";
    }

}
