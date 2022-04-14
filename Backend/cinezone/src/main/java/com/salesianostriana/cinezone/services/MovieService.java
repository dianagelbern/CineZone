package com.salesianostriana.cinezone.services;

import com.salesianostriana.cinezone.models.Movie;
import com.salesianostriana.cinezone.repos.MovieRepository;
import com.salesianostriana.cinezone.services.base.BaseService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class MovieService extends BaseService<Movie, Long, MovieRepository> {
}
