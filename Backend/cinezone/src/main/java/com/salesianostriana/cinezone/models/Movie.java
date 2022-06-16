package com.salesianostriana.cinezone.models;

import com.salesianostriana.cinezone.models.show.Show;
import lombok.*;
import org.hibernate.annotations.Type;

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
    @Type(type = "text")
    private String sinopsis;

    private int duracion;

    private String imagen;

    private String trailer;

  /*  @Builder.Default
    @OneToMany(mappedBy = "movie", fetch = FetchType.LAZY)
    private List<Show> shows = new ArrayList<>();
*/
}
