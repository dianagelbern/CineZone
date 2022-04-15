package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.models.Asiento;
import com.salesianostriana.cinezone.repos.AsientoRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AsientoService extends BaseService<Asiento, Long, AsientoRepository> {
}
