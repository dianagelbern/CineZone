package com.salesianostriana.cinezone.models;

import com.salesianostriana.cinezone.users.model.UserEntity;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDate;

@Entity
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class Tarjeta {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String no_tarjeta;

    private LocalDate fecha_cad;

    private String titular;

    //Usuario asociado
    @ManyToOne
    private UserEntity usuario;
}
