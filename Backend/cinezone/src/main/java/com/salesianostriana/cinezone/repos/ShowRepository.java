package com.salesianostriana.cinezone.repos;

import com.salesianostriana.cinezone.models.show.Show;
import org.joda.time.DateTime;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.List;

public interface ShowRepository extends JpaRepository<Show, Long> {


    @Query(value= """
            SELECT *
            FROM SHOW s
            WHERE s.sala_id = :id
            """, nativeQuery = true)
    Page<Show> findAllShowsBySala(Pageable pageable, @Param("id") Long idSala);


    @Query(value= """
            SELECT *
            FROM SHOW s
            WHERE s.cine_id = :id
            """, nativeQuery = true)
    Page<Show> findAllShowsByCine(Pageable pageable, @Param("id") Long idCine);


    @Query(value= """
            SELECT *
            FROM SHOW s
            WHERE s.movie = :id
            AND s.fecha = :fecha
            """, nativeQuery = true)
    Page<Show> findAllShowsByMovieId(Pageable pageable, @Param("id") Long idmovie, @Param("fecha") LocalDate fecha);


    @Query(value= """
            SELECT *
            FROM SHOW s
            WHERE s.cine_id = :id
            AND s.fecha = :fecha
            ORDER BY movie
            """, nativeQuery = true)
    Page<Show> finsAllShowsByCineId(Pageable pageable, @Param("id") Long idcine, @Param("fecha") LocalDate fecha);

}
