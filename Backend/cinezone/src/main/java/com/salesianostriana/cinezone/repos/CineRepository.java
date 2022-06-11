package com.salesianostriana.cinezone.repos;

import com.salesianostriana.cinezone.models.Cine;
import com.salesianostriana.cinezone.models.show.Show;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.time.LocalDate;
import java.util.Optional;

public interface CineRepository extends JpaRepository<Cine, Long> {


    /*
    @Query(value= """
            SELECT *
            FROM CINE c
            WHERE c.salas
            """, nativeQuery = true)
    Page<Cine> findAllCinesWithMovie(Pageable pageable, @Param("id_movie") Long idMovie, @Param("id_show") Long idShow);

     */

    @Query(value= """
            SELECT * FROM cine c
            JOIN show s
            WHERE s.cine_id  = 1
            AND s.movie = :idMovie
            AND s.fecha = :fecha
            """, nativeQuery = true)
    Page<Cine> findAllShowsByMovieANdCineId(Pageable pageable, @Param("idMovie") Long idmovie, @Param("fecha") LocalDate fecha);

}
