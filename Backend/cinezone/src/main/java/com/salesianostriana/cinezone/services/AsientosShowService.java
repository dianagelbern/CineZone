package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.models.Asiento;
import com.salesianostriana.cinezone.models.asientosshow.AsientosShow;
import com.salesianostriana.cinezone.models.asientosshow.AsientosShowPK;
import com.salesianostriana.cinezone.models.show.Show;
import com.salesianostriana.cinezone.repos.AsientosShowRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import org.springframework.stereotype.Service;

@Service
public class AsientosShowService extends BaseService<AsientosShow, AsientosShowPK, AsientosShowRepository> {


    public AsientosShow crearAsientoParaShow(Asiento a, Show s){

        AsientosShow newAsientoShow = new AsientosShow();


        newAsientoShow.addToAsiento(a);
        newAsientoShow.addToShow(s);
        newAsientoShow.setEsOcupado(false);

        return repositorio.save(newAsientoShow);

    }

}
