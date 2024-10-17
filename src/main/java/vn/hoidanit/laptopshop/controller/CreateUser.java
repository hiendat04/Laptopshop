package vn.hoidanit.laptopshop.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.hoidanit.laptopshop.domain.User;

@Controller
public class CreateUser {
    private User user;

    public CreateUser(User user){
        this.user = user;
    }

    @RequestMapping("/admin/user")
    public String createUser(Model model){
        String email = user.getEmail();
        String password = user.getPassword();
        String fullName = user.getPassword();
        String address = user.getAddress();
        String phone = user.getPhone();

        model.addAttribute("email", email);
        model.addAttribute("password", password);
        model.addAttribute("fullName", fullName);
        model.addAttribute("address", address);
        model.addAttribute("phone", phone);

        return "create";

    }
}
