package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.models.Cine;
import com.salesianostriana.cinezone.repos.CineRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CineService extends BaseService<Cine, Long, CineRepository> {
}
