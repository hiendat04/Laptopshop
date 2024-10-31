package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import vn.hoidanit.laptopshop.domain.Order;
import vn.hoidanit.laptopshop.domain.OrderDetail;
import vn.hoidanit.laptopshop.service.ProductService;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class OrderController {

    private final ProductService productService;

    public OrderController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/admin/order")
    public String getOrderPage(Model model, @RequestParam("page") Optional<String> pageOptional) {
        int page = 1;
        try {
            if(pageOptional.isPresent()){
                page = Integer.parseInt(pageOptional.get());
            }
        } catch (Exception e) {
            
        }
        Pageable pageable = PageRequest.of(page - 1, 1);
        Page<Order> orders = this.productService.getAllOrders(pageable);
        List<Order> listOrders = orders.getContent();
        model.addAttribute("orders", listOrders);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", orders.getTotalPages());
        return "admin/order/show";
    }

    @GetMapping("/admin/order/{id}")
    public String getOrderDetailPage(@PathVariable long id, Model model) {
        Optional<Order> optOrder = this.productService.getOrderById(id);
        if (optOrder != null) {
            Order order = optOrder.get();
            List<OrderDetail> orderDetails = order.getOrderDetails();
            model.addAttribute("orderDetails", orderDetails);
        }
        return "admin/order/detail";
    }

    @GetMapping("/admin/order/update/{id}")
    public String getUpdateOrder(@PathVariable long id, Model model) {
        Optional<Order> optOrder = this.productService.getOrderById(id);
        if (optOrder != null) {
            Order order = optOrder.get();
            model.addAttribute("order", order);
        }
        return "admin/order/update";
    }

    @PostMapping("/admin/order/update/{id}")
    public String postUpdateOrder(
            @ModelAttribute("order") Order order,
            @PathVariable long id) {

        Optional<Order> optOrder = this.productService.getOrderById(id);
        if (optOrder != null) {
            Order currentOrder = optOrder.get();
            currentOrder.setStatus(order.getStatus());
            this.productService.handleSaveOrder(currentOrder);
        }
        return "redirect:/admin/order";
    }

    @GetMapping("/admin/order/delete/{id}")
    public String getDeleteProduct(@PathVariable long id, Model model) {
        Optional<Order> optOrder = this.productService.getOrderById(id);
        if (optOrder != null) {
            Order order = optOrder.get();
            model.addAttribute("order", order);
        }
        model.addAttribute("id", id);
        return "admin/order/delete";
    }

    @PostMapping("/admin/order/delete/{id}")
    public String postDeleteProduct(@PathVariable long id) {
        this.productService.deleteOrderById(id);
        return "redirect:/admin/order";
    }

}
