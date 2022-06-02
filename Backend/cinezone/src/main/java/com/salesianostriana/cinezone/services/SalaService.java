package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.dto.asientodto.CreateAsientoDto;
import com.salesianostriana.cinezone.dto.saladto.CreateSalaDto;
import com.salesianostriana.cinezone.error.exception.entitynotfound.EntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.ListEntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.SingleEntityNotFoundException;
import com.salesianostriana.cinezone.models.Asiento;
import com.salesianostriana.cinezone.models.Cine;
import com.salesianostriana.cinezone.models.Movie;
import com.salesianostriana.cinezone.models.Sala;
import com.salesianostriana.cinezone.repos.SalaRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

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

        List<Asiento> asientos = asientoService.generateAsiento(8, 8, newSala);

        for (Asiento asiento : asientos){
            newSala.getAsientos().add(asiento);
            repositorio.save(newSala);
        }

        return newSala;

    }

    public Page<Sala> findAllSalasByCine(Pageable pageable, Long id){
            return repositorio.encuentraSalasByCineId(pageable, id);
    }

    public Page<Sala> findAllSalasByCineDetails(Pageable pageable, Long id){
        return repositorio.encuentraSalasByCineIdDetails(pageable, id);
    }

    public Sala find(Long id){
        Optional<Sala> optionalSala = repositorio.findById(id);

        if (optionalSala.isEmpty()) {
            throw new SingleEntityNotFoundException(Sala.class);
        } else {
            return optionalSala.get();
        }
    }



    public Optional<?> deleteById(Long id, Sala s){
        Optional<Sala> sala = findById(id);
        if (sala.isPresent()){
            return deleteById(id);
        }else {
            throw new EntityNotFoundException("No se encontró ninguna sala con ese id");
        }
    }

}
