package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.dto.reservadto.CreateReservaDto;
import com.salesianostriana.cinezone.error.exception.entitynotfound.ListEntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.reservasexception.AsientosOcupadosException;
import com.salesianostriana.cinezone.models.Asiento;
import com.salesianostriana.cinezone.models.Cine;
import com.salesianostriana.cinezone.models.Reserva;
import com.salesianostriana.cinezone.models.asientosshow.AsientosShow;
import com.salesianostriana.cinezone.models.asientosshow.AsientosShowPK;
import com.salesianostriana.cinezone.repos.ReservaRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import com.salesianostriana.cinezone.users.model.UserEntity;
import com.salesianostriana.cinezone.users.service.UserEntityService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReservaService extends BaseService<Reserva, Long, ReservaRepository> {

    private final UserEntityService userEntityService;
    private final ShowService showService;
    private final CineService cineService;

    private final AsientosShowService asientoShowService;

    public Reserva createReserva(CreateReservaDto reservaDto, UserEntity currentUser){

        //Buscar el show
        //Buscar el asiento y comprobar que:
                //-No está ocupado
                //- Coincide con el show al que se te está tratando de acceder.


        Cine cine = cineService.find(reservaDto.getCineId());

        AsientosShow asiento = asientoShowService.find(new AsientosShowPK(reservaDto.getAsientoId(), reservaDto.getShowId()));


        Reserva newReserva = Reserva.builder()
                .user(currentUser)
                .cine(cine)
                .build();


        if(asiento.isEsOcupado()){
            throw new AsientosOcupadosException(asiento.getAsiento().getNumero(), asiento.getAsiento().getFila());
        } else {
            asiento.setEsOcupado(true);
            asientoShowService.save(asiento);
            newReserva.setAsientoReservado(asiento);

        }
        repositorio.save(newReserva);
        currentUser.addReserva(newReserva);
        userEntityService.save(currentUser);

     /*   for (Long idAsiento : reservaDto.getAsientoId()){

            asiento = asientoService.find(new AsientosShowPK(idAsiento, reservaDto.getShowId()));

            if(asiento.isEsOcupado()){
                throw new AsientosOcupadosException(asiento.getAsiento().getNumero(), asiento.getAsiento().getFila());
            } else {
                newReserva.getAsientosReservados().add(asiento);

            }


        }
        repositorio.save(newReserva);
        currentUser.addReserva(newReserva);
        userEntityService.save(currentUser);
*/
        return newReserva;

    }

    public Page<Reserva> findAllReservasByUser(Pageable pageable, UserEntity user){
        if (repositorio.findAllReservasByUser(user.getId(), pageable).isEmpty()){
            throw new ListEntityNotFoundException(Reserva.class);
        }else {
            return repositorio.findAllReservasByUser(user.getId(), pageable);
        }
    }
}
