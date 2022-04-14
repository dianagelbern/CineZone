package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.models.Reserva;
import com.salesianostriana.cinezone.repos.ReservaRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ReservaService extends BaseService<Reserva, Long, ReservaRepository> {
}
