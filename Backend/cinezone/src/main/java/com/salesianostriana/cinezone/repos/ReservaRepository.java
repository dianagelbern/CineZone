package com.salesianostriana.cinezone.repos;

import com.salesianostriana.cinezone.models.Reserva;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

public interface ReservaRepository extends JpaRepository<Reserva, Long> {


    @Query(value = """
            SELECT *
            FROM RESERVA r
            WHERE r.cine_id = :id
            """, nativeQuery = true)
    Page<Reserva> findAllReservasByCine(@Param("id") Long cineId, Pageable pageable);
}
