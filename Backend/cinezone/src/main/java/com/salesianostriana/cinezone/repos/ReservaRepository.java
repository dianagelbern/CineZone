package com.salesianostriana.cinezone.repos;

import com.salesianostriana.cinezone.models.Reserva;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.EntityGraph;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.UUID;

public interface ReservaRepository extends JpaRepository<Reserva, UUID> {


    @Query(value = """
            SELECT *
            FROM RESERVA r
            WHERE r.cine_id = :id
            """, nativeQuery = true)
    Page<Reserva> findAllReservasByCine(@Param("id") Long cineId, Pageable pageable);

    @Query(value = """
            SELECT *
            FROM RESERVA r
            WHERE r.user_id = :id
            """, nativeQuery = true)
    Page<Reserva> findAllReservasByUser(@Param("id")UUID id, Pageable pageable);

  /*  @EntityGraph("grafo-reserva-user-asientoReservado-cine")
    Page<Reserva> findAll(Pageable pageable);*/

    /*
    @Query(value = """
            SELECT *
            FROM RESERVA
            JOIN FETCH CINE
            JOIN FETCH ASIENTO_RESERVADO
            JOIN FETCH USER
            """, nativeQuery = true)
    Page<Reserva> findAllReservas(Pageable pageable);
     */
}
