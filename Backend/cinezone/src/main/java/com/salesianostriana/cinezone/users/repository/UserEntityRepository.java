package com.salesianostriana.cinezone.users.repository;

import com.salesianostriana.cinezone.users.model.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;
import java.util.UUID;


public interface UserEntityRepository extends JpaRepository<UserEntity, UUID> {

    Optional<UserEntity> findFirstByEmail(String email);

    @Query(value = """
            SELECT *
            FROM USER_ENTITY u
            JOIN USER_RESERVAS r on (u.id = r.user_id)
            WHERE r.user_id = :id
            """, nativeQuery = true)
    UserEntity findUserByReservaId(@Param("id") UUID id);


    @Query("""
            SELECT p
            FROM UserEntity p
            WHERE p.role = USER
            """)
    Page<UserEntity> findAllUsuarios(Pageable pageable);
}
