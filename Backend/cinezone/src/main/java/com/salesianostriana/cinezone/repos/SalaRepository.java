package com.salesianostriana.cinezone.repos;

import com.salesianostriana.cinezone.models.Cine;
import com.salesianostriana.cinezone.models.Sala;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;
import java.util.Optional;

public interface SalaRepository extends JpaRepository<Sala, Long> {

    @Query(value = """
            SELECT *
            FROM Sala
            WHERE cine = :id
            """, nativeQuery = true)
    Page<Sala> encuentraSalasByCineId(Pageable pageable, @Param("id")Long id);


    //SELECT * FROM SALA JOIN(SELECT COUNT(*) as num_asientos FROM ASIENTO as asiento WHERE SALA_ID = 1 ) JOIN cine as cine WHERE cine = 1
    //SELECT * FROM SALA as sala JOIN(SELECT COUNT(*) as num_asientos FROM ASIENTO as asiento GROUP BY sala_id ) JOIN cine as cine WHERE cine = 1 GROUP BY sala.id
    @Query(value = """
            SELECT *
            FROM Sala as sala
            JOIN(
                SELECT COUNT(*) as num_asientos 
                FROM ASIENTO as asiento 
                GROUP BY sala_id)
            JOIN cine as cine
            WHERE cine = :id
            GROUP BY sala.id
            """, nativeQuery = true)
    Page<Sala> encuentraSalasByCineIdDetails(Pageable pageable, @Param("id")Long id);




}
