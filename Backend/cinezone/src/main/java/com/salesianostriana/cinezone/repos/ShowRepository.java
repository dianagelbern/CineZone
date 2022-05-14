package com.salesianostriana.cinezone.repos;

import com.salesianostriana.cinezone.models.show.Show;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

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
}
