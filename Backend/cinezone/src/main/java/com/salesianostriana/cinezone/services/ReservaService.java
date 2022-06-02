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
import java.util.UUID;

@Service
@RequiredArgsConstructor
public class ReservaService extends BaseService<Reserva, UUID, ReservaRepository> {

    private final UserEntityService userEntityService;
    private final ShowService showService;
    private final CineService cineService;
    private final TarjetaService tarjetaService;

    private final AsientosShowService asientoShowService;

    public Reserva createReserva(CreateReservaDto reservaDto, UserEntity currentUser) {

        Cine cine = cineService.find(reservaDto.getCineId());
        Show show = showService.find(reservaDto.getShowId());


        if (show.getCine() == cine) {
            Reserva newReserva = Reserva.builder()
                    .user(currentUser)
                    .cine(cine)
                    .build();

            if (reservaDto.getTarjetaId() != null) {
                Tarjeta tarjeta = tarjetaService.find(reservaDto.getTarjetaId());
                newReserva.setTarjeta(tarjeta);
            } else {

                Tarjeta newTarjeta = Tarjeta.builder()
                        .fecha_cad(reservaDto.getFecha_cad())
                        .titular(reservaDto.getTitular())
                        .no_tarjeta(reservaDto.getNo_tarjeta())
                        .build();
                tarjetaService.save(newTarjeta);
                currentUser.addTarjeta(newTarjeta);
                userEntityService.save(currentUser);

            }


            AsientosShow asiento = asientoShowService.find(new AsientosShowPK(reservaDto.getAsientoId(), reservaDto.getShowId()));


            if (asiento.isEsOcupado()) {
                throw new AsientosOcupadosException(asiento.getAsiento().getNumero(), asiento.getAsiento().getFila());
            } else {
                asiento.setEsOcupado(true);
                asientoShowService.save(asiento);
                newReserva.setAsientoReservado(asiento);

            }
            repositorio.save(newReserva);
            currentUser.addReserva(newReserva);
            userEntityService.save(currentUser);


            return newReserva;
        } else throw new RelacionInvalidaException("El show no pertenece al cine");


    }

    public Page<Reserva> findAllReservasByUser(Pageable pageable, UserEntity user) {
        return repositorio.findAllReservasByUser(user.getId(), pageable);
    }
}
