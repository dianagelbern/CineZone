package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.dto.cinedto.CreateCineDto;
import com.salesianostriana.cinezone.error.exception.entitynotfound.EntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.ListEntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.SingleEntityNotFoundException;
import com.salesianostriana.cinezone.models.Cine;
import com.salesianostriana.cinezone.models.Sala;
import com.salesianostriana.cinezone.repos.CineRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class CineService extends BaseService<Cine, Long, CineRepository> {


    private final SalaService salaService;

    /**
     * Creamos un nuevo cine y a su vez sus salas
     * @param createCineDto
     * @return Retorna el nuevo cine
     */
    public Cine createCine(CreateCineDto createCineDto){

        Cine cine = Cine.builder()
                .nombre(createCineDto.getNombre())
                .plaza(createCineDto.getPlaza())
                .latLon(createCineDto.getLatLon())
                .direccion(createCineDto.getDireccion()).build();

        repositorio.save(cine);

        for (int i = 1; i <= createCineDto.getNumSalas(); i++){
            Sala newSala = salaService.createSala("Sala "+i, cine);
            cine.getSalas().add(newSala);
            repositorio.save(cine);
        }

        return cine;
    }


    /**
     * Lista todos los cines
     * @param pageable
     * @return Retorna los cines de forma paginada
     */
    public Page<Cine> findAllCines(Pageable pageable){

        return repositorio.findAll(pageable);
    }

    /**
     * Encuentra un cine por su id
     * @param id
     * @param cine
     * @return Retorna el cine o una exception de entidad no encontrada
     */
    public Optional<Cine> findById(Long id, Cine cine){
        if (cine.getId().equals(id)){
            Optional<Cine> c = findById(id);
            return c;
        }else {
            throw new EntityNotFoundException("El cine no existe");
        }
    }

    /**
     * Edita un cine encontrado por medio de su id
     * @param cineDto
     * @param id
     * @return Retorna el cine con sus nuevos valores o una exception de entidad no encontrada
     */
    public Cine edit(CreateCineDto cineDto, Long id){
        Optional<Cine> c = repositorio.findById(id);
        if (c.isPresent()){
            Cine cine = c.get();
            cine.setNombre(cineDto.getNombre());
            cine.setDireccion(cineDto.getDireccion());
            cine.setLatLon(cineDto.getLatLon());
            cine.setPlaza(cineDto.getPlaza());
            return repositorio.save(cine);
        }else {
            throw new SingleEntityNotFoundException(Cine.class, id);
        }
    }

    /**
     * Metodo que nos ayudara en otros servicios para encontrar un cine por su id
     * @param id
     * @return Retorna el cine o una exception de entidad no encontrada
     */
    public  Cine find(Long id){
        Optional<Cine> cine = findById(id);

        if(cine.isPresent()){
            return cine.get();
        } else{
            throw new SingleEntityNotFoundException(Cine.class);
        }

    }

    /*
    public Optional<?> deleteById(Long id, Cine c){
        Optional<Cine> cine  = findById(id);
        if (cine.isPresent()){
            return deleteById(id);
        }else {
            throw new EntityNotFoundException("No se encontró ningún cine con ese id");
        }
    }
     */
}
