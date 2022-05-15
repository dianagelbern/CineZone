package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.dto.tarjetadto.CreateTarjetaDto;
import com.salesianostriana.cinezone.error.exception.entitynotfound.EntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.entitynotfound.ListEntityNotFoundException;
import com.salesianostriana.cinezone.models.Tarjeta;
import com.salesianostriana.cinezone.repos.TarjetaRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import com.salesianostriana.cinezone.users.model.UserEntity;
import com.salesianostriana.cinezone.users.service.UserEntityService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
@RequiredArgsConstructor
public class TarjetaService extends BaseService<Tarjeta, Long, TarjetaRepository> {

    private final UserEntityService userEntityService;

    public Tarjeta createTarjeta(CreateTarjetaDto tarjetaDto, UserEntity currentUser){
        Tarjeta newTarjeta = Tarjeta.builder()
                .usuario(currentUser)
                .titular(tarjetaDto.getTitular())
                .fecha_cad(tarjetaDto.getFecha_cad())
                .no_tarjeta(tarjetaDto.getNo_tarjeta())
                .build();
        repositorio.save(newTarjeta);
        userEntityService.save(currentUser);
        return newTarjeta;
    }

    public Page<Tarjeta> findAllTarjetasByUser(Pageable pageable, UserEntity user){
        if (repositorio.findAllTarjetasByUser(user.getId(), pageable).isEmpty()){
            throw new ListEntityNotFoundException(Tarjeta.class);
        }else {
            return repositorio.findAllTarjetasByUser(user.getId(), pageable);
        }
    }

    public Optional<?> deleteTarjetaById(Long id){
        Optional<Tarjeta> tarjeta = findById(id);
        if (tarjeta.isPresent()){
            return deleteById(id);
        }else{
            throw new EntityNotFoundException("No se encontró ninguna tarjeta con ese id");
        }
    }

}
