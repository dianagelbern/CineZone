package com.salesianostriana.cinezone.repos;

import com.salesianostriana.cinezone.models.asientosshow.AsientosShow;
import com.salesianostriana.cinezone.models.asientosshow.AsientosShowPK;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface AsientosShowRepository extends JpaRepository<AsientosShow, AsientosShowPK> {


    /*
    @Query(value= """
            SELECT *
            FROM ASIENTOS_SHOW
            JOIN ASIENTO as a ON (a.id = asiento_id)
            WHERE show_id = :id
            """, nativeQuery = true)
    Page<AsientosShow> findAllAsientosByShowId(@Param("id") Long show_id, Pageable pageable);
     */

/*    @Query(value = """
            SELECT *
            FROM asientos_show
            JOIN asiento a ON  a.id = asiento_id
            WHERE show_id = :id
            """, nativeQuery = true)
    Page<AsientosShow> findAllAsientosByShowId(@Param("id") Long id, Pageable pageable);*/


    @Query(value = """
            SELECT *
            FROM asientos_show
            JOIN asiento a ON  a.id = asiento_id
            WHERE show_id = :id
            """, nativeQuery = true)
    List<AsientosShow> findAllAsientosByShowId(@Param("id") Long id);
}
