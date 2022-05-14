package com.salesianostriana.cinezone.models.show;


import com.salesianostriana.cinezone.models.Cine;
import com.salesianostriana.cinezone.models.Movie;
import com.salesianostriana.cinezone.models.Sala;
import com.salesianostriana.cinezone.models.asientosshow.AsientosShow;
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
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    //Pelicula asociada
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "movie", foreignKey = @ForeignKey(name = "FK_SHOW_MOVIE"))
    private Movie movie;


    //Sala asociada
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "sala_id")
    private Sala sala;


    @Builder.Default
    @OneToMany(mappedBy = "show")
    private List<AsientosShow> asientosShow = new ArrayList<>();


    private LocalDateTime fecha;

    private String idioma;

    @Enumerated(EnumType.STRING)
    private Formato formato;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cine_id")
    private Cine cine;
}
