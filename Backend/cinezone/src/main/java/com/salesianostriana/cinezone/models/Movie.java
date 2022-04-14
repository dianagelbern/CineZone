package com.salesianostriana.cinezone.models;

import lombok.*;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;


@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class Movie {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String genero, titulo, director, clasificacion, productora;

    @Lob
    private String sinopsis;

    private int duracion;

    private String imagen;

    private String trailer;

    @Builder.Default
    @OneToMany(mappedBy = "movie", fetch = FetchType.LAZY)
    private List<Show> shows = new ArrayList<>();
}
