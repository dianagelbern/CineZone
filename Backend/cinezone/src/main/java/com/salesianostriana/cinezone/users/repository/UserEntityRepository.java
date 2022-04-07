package com.salesianostriana.cinezone.users.repository;

import com.salesianostriana.cinezone.users.model.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.Optional;
import java.util.UUID;

public interface UserEntityRepository extends JpaRepository<UserEntity, UUID> {

    Optional<UserEntity> findFirstByEmail(String email);

    @Query("""
            SELECT p
            FROM UserEntity p
            WHERE p.role = USER
            """)
    Page<UserEntity> findAllUsuarios(Pageable pageable);
}
