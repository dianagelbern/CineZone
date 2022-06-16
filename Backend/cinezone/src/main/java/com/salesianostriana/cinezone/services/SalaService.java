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

    /**
     * Metodo que crea una nueva sala asociada a un cine a su vez generando los asientos, en este caso 8 asientos por 8 filas
     * @param nombre
     * @param cine
     * @return Trae la nueva sala
     */
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

    /**
     * Encuentra todas las salas asociadas a un cine
     * @param pageable
     * @param id
     * @return Retorna la lista de salas de forma paginable
     */
    public Page<Sala> findAllSalasByCine(Pageable pageable, Long id){
            return repositorio.encuentraSalasByCineId(pageable, id);
    }

    /**
     * Trae los detalles de las salas asociadas a un cine
     * @param pageable
     * @param id
     * @return retorna las salas con su id y su nombre
     */
    public Page<Sala> findAllSalasByCineDetails(Pageable pageable, Long id){
        return repositorio.encuentraSalasByCineIdDetails(pageable, id);
    }

    /**
     * Metodo que encuentra una sala por medio de su id que nos servira para usar en otros servicios
     * @param id
     * @return Retorna sala encontrada o una exception de entidad no encontrada
     */
    public Sala find(Long id){
        Optional<Sala> optionalSala = repositorio.findById(id);

        if (optionalSala.isEmpty()) {
            throw new SingleEntityNotFoundException(Sala.class);
        } else {
            return optionalSala.get();
        }
    }


    /**
     * Metodo que elimina la sala por su id
     * @param id
     * @param s
     * @return Si la sala existe la elimina, de lo contrario lanza una exception de entidad no encontrada
     */
    public Optional<?> deleteById(Long id, Sala s){
        Optional<Sala> sala = findById(id);
        if (sala.isPresent()){
            return deleteById(id);
        }else {
            throw new EntityNotFoundException("No se encontró ninguna sala con ese id");
        }
    }

}
