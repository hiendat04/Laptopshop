package vn.hoidanit.laptopshop.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.Cart;
import vn.hoidanit.laptopshop.domain.CartDetail;
import vn.hoidanit.laptopshop.domain.Product;
import java.util.Optional;


@Repository
public interface CartDetailRepository extends JpaRepository<CartDetail, Long> {
    boolean existsByCartAndProduct(Cart cart, Product Product);

    CartDetail findByCartAndProduct(Cart cart, Product Product);

    Optional<CartDetail> findById(long id);

    void deleteById(long id);
}
