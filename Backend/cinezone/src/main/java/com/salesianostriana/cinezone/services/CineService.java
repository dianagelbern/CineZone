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


    public Cine createCine(CreateCineDto createCineDto){

        Cine cine = Cine.builder()
                .plaza(createCineDto.getPlaza())
                .latLon(createCineDto.getLatLon())
                .direccion(createCineDto.getDireccion()).build();

        repositorio.save(cine);

        for (int i = 1; i <= createCineDto.getNumSalas(); i++){
            salaService.createSala("Sala "+i, cine);
            repositorio.save(cine);
        }

        return cine;
    }



    public Page<Cine> findAllCines(Pageable pageable){
        if (repositorio.findAll(pageable).isEmpty()){
            throw new ListEntityNotFoundException(Cine.class);
        }else {
            return repositorio.findAll(pageable);
        }
    }

    public Optional<Cine> findById(Long id, Cine cine){
        if (cine.getId().equals(id)){
            Optional<Cine> c = findById(id);
            return c;
        }else {
            throw new EntityNotFoundException("El cine no existe");
        }
    }


   /*
    public Optional<Cine> getAllSalasByCine(Long id, Cine cine){
        if (cine.getId().equals(id)){
            Optional<Cine> c = repositorio.findAllSalasByCineId(id);
            return c;
        }else {
            throw new EntityNotFoundException("El cine no existe");
        }
    }
    */


    public Cine edit(CreateCineDto cineDto, Long id){
        Optional<Cine> c = repositorio.findById(id);
        if (c.isPresent()){
            Cine cine = c.get();
            cine.setDireccion(cineDto.getDireccion());
            cine.setLatLon(cineDto.getLatLon());
            cine.setPlaza(cineDto.getPlaza());
            return repositorio.save(cine);
        }else {
            throw new SingleEntityNotFoundException(Cine.class, id);
        }
    }

    public Optional<?> deleteById(Long id, Cine c){
        Optional<Cine> cine  = findById(id);
        if (cine.isPresent()){
            return deleteById(id);
        }else {
            throw new EntityNotFoundException("No se encontró ningún cine con ese id");
        }
    }
}
