package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.dto.reservadto.CreateReservaDto;
import com.salesianostriana.cinezone.error.exception.entitynotfound.ListEntityNotFoundException;
import com.salesianostriana.cinezone.error.exception.reservasexception.AsientosOcupadosException;
import com.salesianostriana.cinezone.error.exception.reservasexception.RelacionInvalidaException;
import com.salesianostriana.cinezone.models.Asiento;
import com.salesianostriana.cinezone.models.Cine;
import com.salesianostriana.cinezone.models.Reserva;
import com.salesianostriana.cinezone.models.Tarjeta;
import com.salesianostriana.cinezone.models.asientosshow.AsientosShow;
import com.salesianostriana.cinezone.models.asientosshow.AsientosShowPK;
import com.salesianostriana.cinezone.models.show.Show;
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
import java.util.Optional;
import java.util.UUID;


@Service
@RequiredArgsConstructor
public class ReservaService extends BaseService<Reserva, UUID, ReservaRepository> {

    private final UserEntityService userEntityService;
    private final ShowService showService;
    //private final AsientoService asientoService;
    private final CineService cineService;
    private final TarjetaService tarjetaService;

    private final AsientosShowService asientoShowService;

    public Reserva createReserva(CreateReservaDto reservaDto, UUID userId) {

        Cine cine = cineService.find(reservaDto.getCineId());
        Show show = showService.find(reservaDto.getShowId());
        //Asiento asiento = asientoService.find(reservaDto.getAsientoId());

        //AsientosShow asientoShow = asientoShowService.find(new AsientosShowPK(asiento.getId(), show.getId()));
        UserEntity currentUser = userEntityService.find(userId);
        Tarjeta tarjeta;
        AsientosShow asiento = asientoShowService.find(new AsientosShowPK(reservaDto.getAsientoId(), reservaDto.getShowId()));




        if (show.getCine() == cine) {

            if (asiento.isEsOcupado()) {
                throw new AsientosOcupadosException(asiento.getAsiento().getNumero(), asiento.getAsiento().getFila());
            } else {


            Reserva newReserva = Reserva.builder()
                    .user(currentUser)
                    .cine(cine)
                    .build();

            //Si no es null es porque se ha escogido una tarjeta existente
            if (reservaDto.getTarjetaId() != null) {
                tarjeta = tarjetaService.find(reservaDto.getTarjetaId());


                //Si es null, se ha elegido registrar una tarjeta nueva
            } else {

                //Comprobamos si existe
                Optional<Tarjeta> optTarjeta = tarjetaService.findByNum(reservaDto.getNo_tarjeta());

                //Si existe, hacemos la reserva con esa tarjeta
                if (optTarjeta.isPresent()) {
                    tarjeta = optTarjeta.get();

                } else {

                    //Si no existe, la creamos
                    tarjeta = Tarjeta.builder()
                            .fecha_cad(reservaDto.getFecha_cad())
                            .no_tarjeta(reservaDto.getNo_tarjeta())
                            .titular(reservaDto.getTitular())
                            .build();

                    tarjetaService.save(tarjeta);
                    currentUser.addTarjeta(tarjeta);

                    userEntityService.save(currentUser);



                }

              /*  tarjetaService.save(newTarjeta);
                currentUser.addTarjeta(newTarjeta);
                userEntityService.save(currentUser);*/

            }


            asiento.setEsOcupado(true);
            asientoShowService.save(asiento);
            newReserva.setAsientoReservado(asiento);





            asiento.setReserva(newReserva);
            newReserva.setTarjeta(tarjeta);
            repositorio.save(newReserva);
            currentUser.addReserva(newReserva);

            userEntityService.save(currentUser);


            return newReserva;

            }

            //newReserva.setAsientoReservado(asiento);

        } else throw new RelacionInvalidaException("El show no pertenece al cine");


    }

    public Page<Reserva> findAllReservasByUser(Pageable pageable, UserEntity user) {
        return repositorio.findAllReservasByUser(user.getId(), pageable);
    }
}
