package vn.hoidanit.laptopshop.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.hoidanit.laptopshop.domain.User;
import java.util.List;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {
    User save(User user);

    List<User> findByEmail(String email);

    Page<User> findAll(Pageable pageable);

    User findById(long id);

    void deleteById(long id);

    boolean existsByEmail(String email);

    User findOneByEmail(String email);
}
