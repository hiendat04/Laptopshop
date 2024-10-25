package vn.hoidanit.laptopshop.domain.dto;

import jakarta.validation.constraints.Size;
import vn.hoidanit.laptopshop.service.validator.RegisterChecked;
import vn.hoidanit.laptopshop.service.validator.StrongPassword;

@RegisterChecked
public class RegisterDTO {

    @Size(min = 3, message = "FirstName phải có 3 ký tự!")
    private String firstName;
    private String lastName;
    private String email;

    @StrongPassword(message = "Password phải có ít nhất 8 ký tự")
    private String password;

    @Size(min = 3, message = "Nhập ít nhất 3 ký tự để xác nhận lại mật khẩu!")
    private String confirmPassword;

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getConfirmPassword() {
        return confirmPassword;
    }

    public void setConfirmPassword(String confirmPassword) {
        this.confirmPassword = confirmPassword;
    }

}
