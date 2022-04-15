package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.models.Tarjeta;
import com.salesianostriana.cinezone.repos.TarjetaRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class TarjetaService extends BaseService<Tarjeta, Long, TarjetaRepository> {
}
