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

    //@Query("select s from Sala s where s.cine = :id")
    @Query(value = """
            SELECT *
            FROM Sala
            WHERE cine = :id
            """, nativeQuery = true)
    public Page<Sala> encuentraSalasByCineId(Pageable pageable, @Param("id")Long id);
}
