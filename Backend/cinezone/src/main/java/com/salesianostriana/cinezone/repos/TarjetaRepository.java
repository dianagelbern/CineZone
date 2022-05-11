package com.salesianostriana.cinezone.repos;

import com.salesianostriana.cinezone.models.Tarjeta;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.UUID;

public interface TarjetaRepository extends JpaRepository<Tarjeta, Long> {

    @Query(value = """
            SELECT *
            FROM TARJETA t
            WHERE t.usuario_id = :id
            """, nativeQuery = true)
    Page<Tarjeta> findAllTarjetasByUser(@Param("id")UUID id, Pageable pageable);
}
