// repository/UserRepository.java
package com.tamna.leisure.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.tamna.leisure.domain.User;
import java.util.Optional;

public interface UserRepository extends JpaRepository<User, Long> {
    Optional<User> findByEmail(String email);
    boolean existsByEmail(String email);
    boolean existsByNickname(String nickname);
}
