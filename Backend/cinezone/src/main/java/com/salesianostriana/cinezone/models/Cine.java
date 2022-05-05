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
public class Cine {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String direccion;

    private String latLon;

    private String plaza;


    //Sala asociada
    @Builder.Default
    @OneToMany
    private List<Sala> salas = new ArrayList<>();
}
