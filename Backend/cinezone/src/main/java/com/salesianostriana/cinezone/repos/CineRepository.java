package com.salesianostriana.cinezone.repos;

import com.salesianostriana.cinezone.models.Cine;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.Optional;

public interface CineRepository extends JpaRepository<Cine, Long> {


    /*
    @Query("SELECT s FROM Sala s WHERE s.cine = :id")
    Optional<Cine> findAllSalasByCineId(@Param("id") Long id);
     */

}
