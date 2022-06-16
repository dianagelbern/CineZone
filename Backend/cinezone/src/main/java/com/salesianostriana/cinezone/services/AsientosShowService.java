package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.error.exception.entitynotfound.SingleEntityNotFoundException;
import com.salesianostriana.cinezone.models.Asiento;
import com.salesianostriana.cinezone.models.asientosshow.AsientosShow;
import com.salesianostriana.cinezone.models.asientosshow.AsientosShowPK;
import com.salesianostriana.cinezone.models.show.Show;
import com.salesianostriana.cinezone.repos.AsientosShowRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class AsientosShowService extends BaseService<AsientosShow, AsientosShowPK, AsientosShowRepository> {

    /**
     * Metodo que crea los asientos para un show
     * @param a
     * @param s
     * @return Retorna los nuevos asientos asociados a un show
     */
    public AsientosShow crearAsientoParaShow(Asiento a, Show s){

        AsientosShow newAsientoShow = new AsientosShow();


        newAsientoShow.addToAsiento(a);
        newAsientoShow.addToShow(s);
        newAsientoShow.setEsOcupado(false);

        return repositorio.save(newAsientoShow);

    }

    /**
     * Encuentra el asiento de un show por su id
     * @param id
     * @return Retorna el asiento o una exption de entidad no encotnrada
     */
    public AsientosShow find(AsientosShowPK id){

        Optional<AsientosShow> optionalAsientosShow = repositorio.findById(id);

        if (optionalAsientosShow.isEmpty()){
            throw new SingleEntityNotFoundException(AsientosShow.class);
        } else {
            return optionalAsientosShow.get();
        }


    }


    /**
     * Encuentra todos los asientos asociados a un show por medio de su id
     * @param id
     * @return Retorna la lista de asientos
     */
    public List<AsientosShow> findAllAsientosByShowId(Long id){
        return repositorio.findAllAsientosByShowId(id);
    }

}
