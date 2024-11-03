package vn.hoidanit.laptopshop.controller.client;

import java.util.ArrayList;
import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;

import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.Product;
import vn.hoidanit.laptopshop.domain.Product_;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.domain.dto.ProductCriteriaDTO;
import vn.hoidanit.laptopshop.service.ProductService;
import vn.hoidanit.laptopshop.service.UserService;
import vn.hoidanit.laptopshop.service.specification.ProductSpecs;

import org.springframework.web.bind.annotation.PostMapping;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class ItemController {

    private final ProductService productService;
    private final UserService userService;
    private final ProductSpecs productSpecs;

    public ItemController(ProductService productService, UserService userService, ProductSpecs productSpecs) {
        this.productService = productService;
        this.userService = userService;
        this.productSpecs = productSpecs;
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
        this.productService.handleAddProductToCart(email, productId, session, 1);
        return "redirect:/";
    }

    @GetMapping("/cart")
    public String getCartPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long user_id = (long) session.getAttribute("id");
        User user = this.userService.getUserById(user_id);
        Cart cart = this.productService.getCartByUser(user);

        // check if cart is empty
        List<CartDetail> cartDetails = user.getCart() == null ? new ArrayList<CartDetail>()
                : user.getCart().getCartDetails();
        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("cart", cart);
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

    @GetMapping("/checkout")
    public String getCheckOutPage(Model model, HttpServletRequest request) {
        User currentUser = new User();// null
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        Cart cart = this.productService.getCartByUser(currentUser);

        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();

        double totalPrice = 0;
        for (CartDetail cd : cartDetails) {
            totalPrice += cd.getPrice() * cd.getQuantity();
        }

        model.addAttribute("cartDetails", cartDetails);
        model.addAttribute("totalPrice", totalPrice);

        return "client/cart/checkout";
    }

    @GetMapping("/confirm-checkout")
    public String getCheckoutPage(@ModelAttribute("cart") Cart cart) {
        List<CartDetail> cartDetails = cart == null ? new ArrayList<CartDetail>() : cart.getCartDetails();
        this.productService.handleUpdateCartBeforeCheckout(cartDetails);
        return "redirect:/checkout";
    }

    @PostMapping("/place-order")
    public String handlePlaceOrder(
            HttpServletRequest request,
            @RequestParam("receiverName") String receiverName,
            @RequestParam("receiverAddress") String receiverAddress,
            @RequestParam("receiverPhone") String receiverPhone) {

        User currentUser = new User();
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        currentUser.setId(id);

        this.productService.handlePlaceOrder(currentUser, session, receiverName, receiverAddress, receiverPhone);

        return "redirect:/thank";
    }

    @GetMapping("/thank")
    public String getThankYouPage(Model model) {
        return "client/cart/thank";
    }

    @GetMapping("/order-history")
    public String getHisotyPage(Model model, HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        long id = (long) session.getAttribute("id");
        User user = this.userService.getUserById(id);
        List<Order> orders = user.getOrders();
        model.addAttribute("orders", orders);
        return "client/history/show";
    }

    @PostMapping("/update-quantity-from-detail")
    public String postUpdateProductCartQuantity(
            Model model,
            @RequestParam long id,
            HttpServletRequest request,
            @RequestParam("quantity") long quantity) {

        HttpSession session = request.getSession(false);
        String email = (String) session.getAttribute("email");
        this.productService.handleAddProductToCart(email, id, session, quantity);
        return "redirect:/cart";
    }

    @GetMapping("/products")
    public String postProductsPage(
            Model model,
            ProductCriteriaDTO productCriteriaDTO,
            HttpServletRequest request) {

        int page = 1;
        try {
            if (productCriteriaDTO.getPage().isPresent()) {
                page = Integer.parseInt(productCriteriaDTO.getPage().get());
            }
        } catch (Exception e) {
        }

        Pageable pageable = PageRequest.of(page - 1, 3);
        if (productCriteriaDTO.getSort() != null && productCriteriaDTO.getSort().isPresent()) {
            String sort = productCriteriaDTO.getSort().get();
            if (sort.equals("gia-tang-dan")) {
                pageable = PageRequest.of(page - 1, 3, Sort.by(Product_.PRICE).ascending());
            } else {
                pageable = PageRequest.of(page - 1, 3, Sort.by(Product_.PRICE).descending());

            }
        }
        Page<Product> products = this.productService.getAllProductsWithSpec(pageable, productCriteriaDTO);
        List<Product> listProducts = products.getContent().size() > 0 ? products.getContent()
                : new ArrayList<Product>();
        
        String qs = request.getQueryString();
        if (qs != null && !qs.isBlank()){
            qs = qs.replace("page=" + page, "");
        }
        model.addAttribute("products", listProducts);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", products.getTotalPages());
        model.addAttribute("queryString", qs);

        return "client/product/show";
    }

}
