package com.salesianostriana.cinezone.models;

import lombok.*;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.OneToMany;
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
    private Long id;

    private String direccion;

    private String latLon;

    private String plaza;

    //Sala asociada
    @OneToMany
    private List<Sala> salas = new ArrayList<>();
}
