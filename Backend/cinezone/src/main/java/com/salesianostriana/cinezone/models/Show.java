package com.salesianostriana.cinezone.models;


import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@NamedEntityGraphs({
        @NamedEntityGraph(
                name = "grafo-show-sala-movie",
                attributeNodes = {
                        @NamedAttributeNode("sala"),
                        @NamedAttributeNode("movie")
                }
        ),
        @NamedEntityGraph(
                name = "grafo-show-sala",
                attributeNodes = {
                        @NamedAttributeNode("sala")
                }
        ),
        @NamedEntityGraph(
                name = "grafo-show-movie",
                attributeNodes = {
                        @NamedAttributeNode("movie")
                }
        )
})
@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class Show {

    @Id
    private Long id;

    //Pelicula asociada
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "movie", foreignKey = @ForeignKey(name = "FK_SHOW_MOVIE"))
    private Movie movie;


    //Sala asociada
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "show")
    private Sala sala;

    //private List<LocalDateTime> horarios = new ArrayList<>();

    private LocalDate fecha_inicio;

    private LocalDate fecha_fin;

    private String idioma, formato;
}
