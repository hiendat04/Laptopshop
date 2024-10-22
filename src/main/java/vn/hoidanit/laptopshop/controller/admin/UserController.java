package vn.hoidanit.laptopshop.controller.admin;

import java.util.List;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jakarta.validation.Valid;
import vn.hoidanit.laptopshop.domain.User;
import vn.hoidanit.laptopshop.service.UploadService;
import vn.hoidanit.laptopshop.service.UserService;
import org.springframework.web.bind.annotation.PostMapping;

import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class UserController {

    private final UserService userService;
    private final UploadService uploadService;
    private PasswordEncoder passwordEncoder;

    public UserController(UserService userService, UploadService uploadService, PasswordEncoder passwordEncoder) {
        this.userService = userService;
        this.uploadService = uploadService;
        this.passwordEncoder = passwordEncoder;
    }

    @GetMapping("/admin/user")
    public String getUserPage(Model model) {
        List<User> users = this.userService.getAllUsers();
        model.addAttribute("Users", users);
        return "admin/user/show";
    }

    @GetMapping("/admin/user/{id}")
    public String getUserDetailPage(Model model, @PathVariable long id) {
        User user = this.userService.getUserById(id);
        model.addAttribute("user", user);
        return "admin/user/detail";
    }

    @GetMapping("/admin/user/create")
    public String getCreateUserPage(Model model) {
        model.addAttribute("newUser", new User());
        return "admin/user/create";
    }

    @PostMapping(value = "/admin/user/create")
    public String createUserPage(@ModelAttribute("newUser") @Valid User newUser,
            BindingResult bindingResult,
            @RequestParam("uploadedFile") MultipartFile file) {

        // validate
        List<FieldError> errors = bindingResult.getFieldErrors();
        for (FieldError error : errors) {
            System.out.println(error.getObjectName() + " - " + error.getDefaultMessage());
        }

        String avatar = this.uploadService.handleSaveUploadFile(file, "avatar");
        String hashPashword = this.passwordEncoder.encode(newUser.getPassword());

        newUser.setAvatar(avatar);
        newUser.setPassword(hashPashword);
        newUser.setRole(this.userService.getRoleByName(newUser.getRole().getName()));
        this.userService.handleSaveUser(newUser);
        return "redirect:/admin/user";
    }

    @RequestMapping("/admin/user/update/{id}")
    public String getUpdateUserPage(Model model, @PathVariable long id) {
        User currentUser = this.userService.getUserById(id);
        model.addAttribute("updatedUser", currentUser);
        return "admin/user/update";
    }

    @PostMapping("/admin/user/update")
    public String postUpdateUser(Model model, @ModelAttribute("updatedUser") User user) {
        User currentUser = this.userService.getUserById(user.getId());
        if (currentUser != null) {
            currentUser.setPhone(user.getPhone());
            currentUser.setFullName(user.getFullName());
            currentUser.setAddress(user.getAddress());
            currentUser.setAvatar(user.getAvatar());
            currentUser.setRole(this.userService.getRoleByName(user.getRole().getName()));
            this.userService.handleSaveUser(currentUser);
        }
        return "redirect:/admin/user";
    }

    @GetMapping("/admin/user/delete/{id}")
    public String getDeleteUserPage(Model model, @ModelAttribute("currentUser") User currentUser,
            @PathVariable long id) {
        model.addAttribute("id", id);
        return "/admin/user/delete";
    }

    @PostMapping("/admin/user/delete")
    public String postDeleteUser(@ModelAttribute("currentUser") User currentUser) {
        this.userService.deleteUserById(currentUser.getId());
        return "redirect:/admin/user";

    }

}
