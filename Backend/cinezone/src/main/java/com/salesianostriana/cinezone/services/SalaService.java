package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.dto.asientodto.CreateAsientoDto;
import com.salesianostriana.cinezone.dto.saladto.CreateSalaDto;
import com.salesianostriana.cinezone.models.Asiento;
import com.salesianostriana.cinezone.models.Cine;
import com.salesianostriana.cinezone.models.Sala;
import com.salesianostriana.cinezone.repos.SalaRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class SalaService extends BaseService<Sala, Long, SalaRepository> {

    private final AsientoService asientoService;


    public Sala createSala(String nombre, Cine cine){

        Sala newSala = Sala.builder()
                .nombre(nombre)
                .cine(cine)
                .build();
        repositorio.save(newSala);

        List<Asiento> asientos = asientoService.generateAsiento(10, 10, newSala);

        for (Asiento asiento : asientos){
            newSala.getAsientos().add(asiento);
            repositorio.save(newSala);
        }



        return newSala;


    }

}
