package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.models.Sala;
import com.salesianostriana.cinezone.repos.SalaRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class SalaService extends BaseService<Sala, Long, SalaRepository> {
}
