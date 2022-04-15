package com.salesianostriana.cinezone.models;

import lombok.*;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
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
    private Long id;

    private int fila;
    private int numero;
    private int estado;

    @ManyToOne
    private Sala sala;

    @OneToMany
    private List<AsientoReservado> asientosReservados = new ArrayList<>();
}
