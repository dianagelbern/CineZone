package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.models.Show;
import com.salesianostriana.cinezone.repos.ShowRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class ShowService extends BaseService<Show, Long, ShowRepository> {
}
