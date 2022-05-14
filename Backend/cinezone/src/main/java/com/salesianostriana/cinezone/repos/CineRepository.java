package com.salesianostriana.cinezone.repos;

import com.salesianostriana.cinezone.models.Cine;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

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
}
