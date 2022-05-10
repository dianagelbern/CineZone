package com.salesianostriana.cinezone.models;

import com.salesianostriana.cinezone.models.asientosshow.AsientosShow;
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
public class Asiento {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private int fila;
    private int numero;
    //private boolean esOcupado;

    @ManyToOne
    private Sala sala;


    @OneToMany(mappedBy = "asiento")
    private List<AsientosShow> asientosShows = new ArrayList<>();

    /*@ManyToOne
    private Reserva reserva;*/
}
