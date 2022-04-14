package com.salesianostriana.cinezone.repos;

import com.salesianostriana.cinezone.models.Movie;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MovieRepository extends JpaRepository<Movie, Long> {
}
